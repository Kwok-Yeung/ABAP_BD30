*&---------------------------------------------------------------------*
*&  Include           ZBD030_22YY_DYNPROS_A_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  INIT_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_alv OUTPUT.

  IF go_container IS BOUND.
    CALL METHOD go_alv_grid->refresh_table_display( ).
  ELSE.
    CREATE OBJECT go_container
      EXPORTING
*       parent                      =
        container_name              = 'CONTROL_AREA_FLIGHTS'
*       style                       =
*       lifetime                    = lifetime_default
*       repid                       =
*       dynnr                       =
*       no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      EXIT.
    ENDIF.


    CREATE OBJECT go_alv_grid
      EXPORTING
*       i_shellstyle      = 0
*       i_lifetime        =
        i_parent          = go_container
*       i_appl_events     = space
*       i_parentdbg       =
*       i_applogparent    =
*       i_graphicsparent  =
*       i_name            =
*       i_fcat_complete   = SPACE
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      EXIT.
    ENDIF.

    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
*        i_buffer_active               =
*        i_bypassing_buffer            =
*        i_consistency_check           =
        i_structure_name              = 'ZBD030_S_FLIGHT'
*        is_variant                    =
*        i_save                        =
*        i_default                     = 'X'
*        is_layout                     =
*        is_print                      =
*        it_special_groups             =
*        it_toolbar_excluding          =
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab = gt_flights
*       it_fieldcatalog               =
*       it_sort   =
*       it_filter =
*      EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error                 = 2
*       too_many_lines                = 3
*       others    = 4
      .
    IF sy-subrc <> 0.
      MESSAGE i005(zbd030).
    ENDIF.

  ENDIF.
ENDMODULE.
