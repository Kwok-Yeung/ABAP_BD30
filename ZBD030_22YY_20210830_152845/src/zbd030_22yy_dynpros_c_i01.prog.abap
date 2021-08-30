*&---------------------------------------------------------------------*
*&  Include           ZBD030_22YY_DYNPROS_A_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE gf_ok_Code.
    when 'GO'.

      CALL FUNCTION 'Z_BD030_22YY_CONNECTION_GET'
        EXPORTING
          if_carrid = zbd030_s_dynconn-carrid
          if_connid = zbd030_s_dynconn-connid
       IMPORTING
         ES_CONNECTION       =  gs_connection
       EXCEPTIONS
         NO_DATA   = 1
         OTHERS    = 2
        .

      IF sy-subrc = 0.
        MOVE-CORRESPONDING gs_connection to zbd030_s_dynconn.
*       Implement suitable error handling here
      SET SCREEN 200.
      else.
        MESSAGE i011(zbd030) With zbd030_s_dynconn-carrid zbd030_s_dynconn-connid.
      Endif.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE gf_ok_Code.
    when 'BACK'.
      CLEAR zbd030_s_dynconn.
      SET SCREEN 100.
    when 'EXIT'.
      SET SCREEN 0.
  ENDCASE.

ENDMODULE.
