*&---------------------------------------------------------------------*
*& Include ZBD030_22YY_DYNPROS_A_TOP                         Modulpool        ZBD030_22YY_DYNPROS_A
*&
*&---------------------------------------------------------------------*
PROGRAM zbd030_22yy_dynpros_a.
TABLES: zbd030_s_dynconn.

DATA: gf_ok_code TYPE sy-ucomm.
DATA: gs_connection        TYPE zbd030_s_connection,
      gt_flights           TYPE zbd030_t_flights,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid TYPE REF TO cl_gui_alv_grid
      .
