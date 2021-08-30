*&---------------------------------------------------------------------*
*& Report  ZBD030_22YY_SALV_A
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zbd030_22yy_salv_a.

type-pools: icon.

TYPES: begin of ts_ictab,
        icon TYPE icon_d.
        include structure zbd030_s_flight.
types END OF  ts_ictab.
types      tt_ictab TYPE STANDARD TABLE OF ts_ictab WITH DEFAULT KEY.
*

DATA: gs_sflight TYPE zbd030_s_flight
      ,gt_flights TYPE zbd030_t_flights
      ,go_table   Type ref to cl_salv_table,
      gt_table_icon TYPE tt_ictab
      .

PARAMETERS: p_carr TYPE s_carr_id.
SELECT-OPTIONS s_connid FOR gs_sflight-connid.


INITIALIZATION.
p_carr = 'AA'.


START-OF-SELECTION.
TRY.
  zcl_bd030_flightmodel=>get_flights_range(
  EXPORTING
    if_carrid  = p_carr
    it_connid  = s_connid[]
  IMPORTING
    et_flights = gt_flights
    ).

MOVE-CORRESPONDING gt_flights to gt_table_icon.

LOOP AT gt_table_icon INTO data(gs_icon).
  IF gs_icon-percentage > '0.5'.
    gs_icon-icon = icon_red_light.
    else.
      gs_icon-icon = icon_green_light.
  ENDIF.
        MODIFY gt_table_icon FROM gs_icon TRANSPORTING icon.

ENDLOOP.

  cl_salv_table=>factory( IMPORTING r_salv_table = go_table
                          CHANGING t_table = "gt_flights ).
                            gt_table_icon ).

  go_table->display( ).

 CATCH zcx_bd030_no_data .
   MESSAGE i006(zbd030).
ENDTRY.

at SELECTION-SCREEN.
  TRY.
  CALL METHOD zcl_bd030_flightmodel=>check_authority
    EXPORTING
      if_carrid   = p_carr
      if_activity = '03'
      .
   CATCH zcx_bd030_no_auth .
     Message e007(zbd030).
  ENDTRY.
