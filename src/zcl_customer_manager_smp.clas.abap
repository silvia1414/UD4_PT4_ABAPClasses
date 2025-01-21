CLASS zcl_customer_manager_smp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: add_customer
      IMPORTING
        customer_id     TYPE z_customer_id_smp
        customer_name   TYPE z_customer_name_smp
        customer_activo TYPE z_customer_activo_smp
      EXPORTING
        check_code      TYPE sy-subrc,

    update_customer
      IMPORTING
        customer_id     TYPE z_customer_id_smp
        customer_name   TYPE z_customer_name_smp
        customer_activo TYPE z_customer_activo_smp
      EXPORTING
        check_code      TYPE sy-subrc,

    delete_customer
      IMPORTING
        customer_id     TYPE z_customer_id_smp
      EXPORTING
        check_code      TYPE sy-subrc.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_customer_manager_smp IMPLEMENTATION.

  METHOD add_customer.
    DATA: ls_customer TYPE zstruct_customer_smp.

    ls_customer-customer_id = customer_id.
    ls_customer-customer_name = customer_name.
    ls_customer-customer_activo = customer_activo.

    INSERT INTO ztcustomer_smp VALUES @ls_customer.
    check_code = sy-subrc.
  ENDMETHOD.

  METHOD update_customer.
    UPDATE ztcustomer_smp SET
      customer_name = @customer_name,
      customer_activo = @customer_activo
    WHERE customer_id = @customer_id.

    check_code = sy-subrc.
  ENDMETHOD.

  METHOD delete_customer.
    DELETE FROM ztcustomer_smp WHERE customer_id = @customer_id.

    check_code = sy-subrc.
  ENDMETHOD.

ENDCLASS.
