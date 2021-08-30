*&---------------------------------------------------------------------*
*& Report  ZBD030_22YY_ITAB_LOOP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZBD030_22YY_ITAB_LOOP.

DATA: gt_connections TYPE zbd030_t_connections,
      gs_connection TYPE zbd030_s_connection.

TRY.
  CALL METHOD zcl_bd030_flightmodel=>get_connections
  IMPORTING
    et_connections = gt_connections
  .
 CATCH zcx_bd030_no_data .
   WRITE: / 'Keine Daten'.
   Return.

ENDTRY.

LOOP AT gt_connections INTO gs_connection.
  WRITE: / gs_connection-carrid
       ,gs_connection-connid
       ,gs_connection-cityfrom
       ,gs_connection-cityto
       ,gs_connection-airpfrom
       ,gs_connection-airpto
       ,gs_connection-fltime
       ,gs_connection-deptime
       ,gs_connection-arrtime
       .
ENDLOOP.
