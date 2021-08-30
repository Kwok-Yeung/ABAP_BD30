FUNCTION Z_BD030_22YY_AUTH_CHECH.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IF_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IF_ACTIVITY) TYPE  ACTIV_AUTH
*"  EXCEPTIONS
*"      NO_AUTH
*"      WRONG_ACTIVITY
*"----------------------------------------------------------------------
  CASE if_activity.
    WHEN '01' or '02' or '03'.

      AUTHORITY-CHECK OBJECT 'S_CARRID'
               ID 'CARRID' FIELD if_carrid
               ID 'ACTVT' FIELD if_activity.
      IF sy-subrc <> 0.
         Raise no_auth.
      ENDIF.


    WHEN OTHERS.
      Raise wrong_activity.
  ENDCASE.




ENDFUNCTION.
