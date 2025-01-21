CLASS zcl_main_smp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_main_smp IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lt_customers TYPE TABLE OF ztcustomer_smp,   " Definir tabla interna para los clientes
          zv_tsl TYPE timestampl,                      " Definir la variable para el timestamp
          lv_check_code TYPE sy-subrc.                 " Variable para capturar el código de verificación

    GET TIME STAMP FIELD zv_tsl.  " Obtener la marca de tiempo del sistema

    " Llenar la tabla interna con los datos
    lt_customers = VALUE #(
        ( customer_id = 'C001'
          customer_name = 'John Doe'
          customer_activo = 'X' )

        ( customer_id = 'C002'
          customer_name = 'Jane Smith'
          customer_activo = 'X' )

        ( customer_id = 'C003'
          customer_name = 'Bob Brown'
          customer_activo = ' ' )

        ( customer_id = 'C004'
          customer_name = 'Williams'
          customer_activo = 'X' )
    ).

    " Eliminar las entradas anteriores y agregar las nuevas
    DELETE FROM ztcustomer_smp.  " Eliminar registros previos

    INSERT ztcustomer_smp FROM TABLE @lt_customers.  " Insertar nuevos registros desde la tabla interna

    " Verificar el número de registros afectados y mostrar en la consola
    out->write( sy-dbcnt ).  " Mostrar el número de registros afectados
    out->write( 'DONE!' ).    " Mensaje de finalización

    " Recorrer la tabla interna lt_customers y mostrar los resultados
    LOOP AT lt_customers INTO DATA(lv_customer).
      out->write( |ID: { lv_customer-customer_id } Nombre: { lv_customer-customer_name } Activo: { lv_customer-customer_activo }| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
