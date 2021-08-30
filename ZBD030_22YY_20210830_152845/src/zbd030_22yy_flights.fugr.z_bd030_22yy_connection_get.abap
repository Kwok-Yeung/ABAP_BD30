FUNCTION z_bd030_22yy_connection_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IF_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IF_CONNID) TYPE  S_CONN_ID
*"  EXPORTING
*"     REFERENCE(ES_CONNECTION) TYPE  ZBD030_S_CONNECTION
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------

  SELECT SINGLE *
    FROM  spfli
     INTO CORRESPONDING FIELDS OF es_connection
      WHERE carrid = if_carrid
    AND
      connid = if_connid.

  If sy-subrc NE 0.
    Raise no_data.
  endif.

ENDFUNCTION.
