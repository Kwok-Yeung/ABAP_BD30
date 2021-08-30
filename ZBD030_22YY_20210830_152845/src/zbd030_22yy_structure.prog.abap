REPORT zbd030_22yy_structure.

TYPES: BEGIN OF ts_flight,
         carrid     TYPE s_carr_id,
         carrname   TYPE s_carrname,
         currcode   TYPE s_currcode,
         url        TYPE s_carrurl,
         connid     TYPE s_conn_id,
         fldate     TYPE s_date,
         seatmax    TYPE s_seatsmax,
         seatocc    TYPE s_seatsocc,
         percentage TYPE zbd030_perc,
       END OF ts_flight.

DATA:  gs_flight  TYPE zbd030_s_flight,
       gs_carrier TYPE zbd030_s_carrier,
       gs_gesamt  TYPE ts_flight.

PARAMETER: p_carr TYPE s_carr_id,
           p_conn TYPE s_conn_id,
           p_fldate TYPE s_date.

TRY.
    zcl_bd030_flightmodel=>get_carrier(
             EXPORTING if_carrid = p_carr
             IMPORTING es_carrier = gs_carrier
             ).
  CATCH zcx_bd030_no_data.
    WRITE: / 'Keine Daten.'(001).
    RETURN.
  CATCH zcx_bd030_no_auth.
    WRITE: / 'Keine Berechtigung.'.
    RETURN.

ENDTRY.

TRY.
    zcl_bd030_flightmodel=>get_flight(
             EXPORTING if_carrid = p_carr
                       if_connid = p_conn
                       if_fldate = p_fldate
             IMPORTING es_flight = gs_flight
             ).
  CATCH zcx_bd030_no_data.
    WRITE: / 'Keine Flug-Daten.'.
    RETURN.

ENDTRY.

MOVE-CORRESPONDING gs_flight TO gs_gesamt.
MOVE-CORRESPONDING gs_carrier TO gs_gesamt.



WRITE: / gs_gesamt-carrid,
         gs_gesamt-carrname   ,
         gs_gesamt-currcode   ,
         gs_gesamt-url        ,
         gs_gesamt-connid     ,
         gs_gesamt-fldate     ,
         gs_gesamt-seatmax    ,
         gs_gesamt-seatocc    ,
         gs_gesamt-percentage .
