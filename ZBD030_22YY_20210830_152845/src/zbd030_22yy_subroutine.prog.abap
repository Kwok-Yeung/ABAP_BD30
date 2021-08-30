*&---------------------------------------------------------------------*
*& Report  ZBD030_22YY_COMPUTE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zbd030_22yy_subroutine.
TYPES tf_erg TYPE p LENGTH 16 DECIMALS 2.

DATA gf_ergebnis TYPE p LENGTH 16 DECIMALS 2.
DATA gf_null TYPE abap_bool.

PARAMETERS: p_int1 TYPE i,
            p_op   TYPE c,
            p_int2 TYPE i.


CASE p_op.
  WHEN '+'.
    gf_ergebnis = p_int1 + p_int2.
  WHEN '-'.
    gf_ergebnis = p_int1 - p_int2.
  WHEN '*'.
    gf_ergebnis = p_int1 * p_int2.
  WHEN '/'.
    IF p_int2 = 0.
      WRITE: / 'Division durch Null ist nicht erlaubt!!'(001).
      RETURN.
    ELSE.
      gf_ergebnis = p_int1 / p_int2.
    ENDIF.
  WHEN '%'.
    CALL FUNCTION 'Z_BD030_22YY_PERC'
        EXPORTING
            if_int1     = p_int1
            if_int2     = p_int2
        IMPORTING
            ef_ergebnis = gf_ergebnis
        EXCEPTIONS
            proz_v_null = 1.
      IF sy-subrc NE 0.
        WRITE: / text-prz.
        RETURN.
      ENDIF.
**    IF p_int2 = 0.
**      WRITE: / 'Prozent von Null ist nicht erlaubt!!'(prz).
**     RETURN.
**    ELSE.
*    PERFORM calc_perc
*                USING
*                    p_int1
*                    p_int2
*                CHANGING
*                   gf_ergebnis
*                   gf_null.
*
*    IF gf_null = abap_true.
*      WRITE: / text-prz.
*      RETURN.
**    ENDIF.
*
**    ENDIF.

  WHEN 'P'.
    CALL FUNCTION 'Z_BD030_SOL_POWER'
        EXPORTING
            if_base     = p_int1
            if_power    = p_int2
        IMPORTING
            ef_result   = gf_ergebnis
        EXCEPTIONS
            power_value_too_high    = 1
            result_value_too_high   = 2
            OTHERS                  = 3.

  CASE sy-subrc.
    WHEN 0.
    WHEN 1.
        WRITE: 'Die Potenz ist zu hoch.'."(pwh).
        RETURN.
    WHEN 2.
        WRITE: 'Das Ergebnis ist zu hoch.'."(prh).
        RETURN.
    WHEN OTHERS.
        WRITE: 'Unbekannter Fehler.'.
        RETURN.
   ENDCASE.


  WHEN OTHERS.
    WRITE: / p_op, 'ist ungültiger Operator'(002).
    RETURN.
ENDCASE.

WRITE: 'Das Ergebnis ist: '(003), gf_ergebnis.

FORM calc_perc
      USING
            VALUE(uf_int1) TYPE i
            VALUE(uf_int2) TYPE i
      CHANGING
        cf_erg TYPE tf_erg
        cf_null TYPE abap_bool.

  DATA lf_erg TYPE tf_erg.

  IF uf_int2 = 0.
**    MESSAGE i001(zbd030)
    cf_null = abap_true.
  ELSE.
    lf_erg = uf_int1 * 100 / uf_int2.
    cf_erg = lf_erg.
  ENDIF.
ENDFORM.
