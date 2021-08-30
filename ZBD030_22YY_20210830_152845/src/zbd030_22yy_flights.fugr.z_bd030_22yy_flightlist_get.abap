FUNCTION z_bd030_22yy_flightlist_get.
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

  DATA ls_flight TYPE zbd030_s_flight.

  SELECT *
    FROM sflights INTO CORRESPONDING FIELDS OF ls_flight
      WHERE carrid = if_carrid
    AND
      connid = if_connid.

    TRY.
        ls_flight-percentage = zbd030_22yy_comp=>calc_perc(
            if_int1 = ls_flight-seatsocc
            if_int2 = ls_flight-seatsmax
            ).
      CATCH cx_sy_zerodivide .
    ENDTRY.



    APPEND ls_flight TO et_flights.
  ENDSELECT.

  IF sy-subrc NE 0.
    RAISE no_data.
  ENDIF.

ENDFUNCTION.
