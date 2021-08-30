*&---------------------------------------------------------------------*
*& Report  ZBD030_SALV
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zbd030_salv_b_22yy.

DATA:       gt_flights TYPE zbd030_t_flights,
            gs_flight  TYPE zbd030_s_flight,
            gs_sflight TYPE zbd030_s_flight
      ,go_table   Type ref to cl_salv_table..

PARAMETERS: p_car TYPE zbd030_s_flight-carrid.
SELECT-OPTIONS s_con FOR gs_sflight-connid.

START-OF-SELECTION.

  TRY.
      CALL METHOD zcl_bd030_flightmodel=>get_flights_range
        EXPORTING
          if_carrid = p_car
          it_connid = s_con[]
        IMPORTING
          et_flights = gt_flights.



  cl_salv_table=>factory( IMPORTING r_salv_table = go_table
                          CHANGING t_table = gt_flights ).

  go_table->display( ).

    CATCH zcx_bd030_no_data .
  ENDTRY.

  " Writanweiung auskommentieren
*  WRITE:  gs_sflight-carrid,
*          gs_sflight-connid,
*          gs_sflight-fldate,
*          gs_sflight-seatsmax,
*          gs_sflight-seatsocc.



*----------------------------------------------------------------------*
* Ausgabe mit Hilfe von SALV
*----------------------------------------------------------------------*
* Hier muss nichts mehr angepasst werden.
* Das Coding muss nur einkommentiert werden, dabei darauf achten nicht
* beim zweiten mal die Kommentare mit " einzukommentieren.
*----------------------------------------------------------------------*

*  DATA: lo_table            TYPE REF TO cl_salv_table,
*        lo_display_settings TYPE REF TO cl_salv_display_settings,
*        lo_funcions_list    TYPE REF TO cl_salv_functions_list,
*        lo_columns          TYPE REF TO cl_salv_columns,
*        lo_column           TYPE REF TO cl_salv_column,
*        lf_medium_text      TYPE scrtext_m,
*        lf_long_text        TYPE scrtext_l,
*        lf_short_text       TYPE scrtext_s,
*        lf_columnname       TYPE lvc_fname.
*
*  IF gt_flights IS NOT INITIAL.
*
*    TRY .
*        IF lo_table IS INITIAL.
*          cl_salv_table=>factory( IMPORTING r_salv_table = lo_table
*                                  CHANGING  t_table      = gt_flights ).
*          " Titel
*          lo_display_settings = lo_table->get_display_settings( ).
*          lo_display_settings->set_list_header( text-001 ).
*          lo_display_settings->set_striped_pattern( if_salv_c_bool_sap=>true ).
*
*          " Funktionen
*          lo_funcions_list = lo_table->get_functions( ).
*          lo_funcions_list->set_all( if_salv_c_bool_sap=>true ).
*
*          " Spalten
*          lo_columns = lo_table->get_columns( ).
*          lo_columns->set_optimize( 'X' ).
*
*          "Feldbezeichner ändern
*          "lo_column     = lo_columns->get_column( '<Feldname>' ).
*          "lf_long_text  = 'Bezeichnung'.
*          "lo_column->set_short_text( lf_short_text ).
*          "lo_column->set_long_text( lf_long_text ).
*
*          " Felder nicht anzeigen:
*          "lo_column = lo_columns->get_column( 'MANDT' ).
*          "lo_column->set_visible( abap_false ).
*
*          lo_table->display( ).
*
*        ENDIF.
*
*      CATCH cx_salv_msg.
*
*    ENDTRY.
*  ENDIF.
