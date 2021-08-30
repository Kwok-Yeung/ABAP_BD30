FUNCTION Z_BD030_22YY_FLIGHTLIST_GET_OP.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IF_CARRID) TYPE  S_CARRID
*"     REFERENCE(IF_CONNID) TYPE  S_CONN_ID
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  ZBD030_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

SELECT *
  FROM sflights into CORRESPONDING FIELDS OF TABLE et_flights
    Where carrid = if_carrid
    And   connid = if_connid.

  if sy-subrc = 0.
    LOOP AT et_flights INTO data(ls_flight).
     TRY.
      ls_flight-percentage = zbd030_22yy_comp=>calc_perc(
        EXPORTING
          if_int1     = ls_flight-seatsocc
          if_int2     = ls_flight-seatsmax
        ).
       CATCH cx_sy_zerodivide .
      ENDTRY.

      MODIFY et_flights FROM ls_flight TRANSPORTING percentage.
    ENDLOOP.

  else.
    Raise no_data.
  endif.

ENDFUNCTION.
