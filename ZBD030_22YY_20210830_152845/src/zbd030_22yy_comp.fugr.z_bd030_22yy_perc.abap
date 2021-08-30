FUNCTION Z_BD030_22YY_PERC.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IF_INT1) TYPE  I
*"     REFERENCE(IF_INT2) TYPE  I
*"  EXPORTING
*"     REFERENCE(EF_ERGEBNIS) TYPE  ZBD030_PERC
*"  EXCEPTIONS
*"      PROZ_V_NULL
*"----------------------------------------------------------------------

IF if_int2 = 0.
  RAISE proz_v_null.
ELSE.
  ef_ergebnis = if_int1 * 100 / if_int2.
ENDIF.



ENDFUNCTION.
