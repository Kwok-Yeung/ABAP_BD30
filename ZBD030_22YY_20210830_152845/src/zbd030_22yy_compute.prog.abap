*&---------------------------------------------------------------------*
*& Report  ZBD030_22YY_COMPUTE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zbd030_22yy_compute.

DATA gf_ergebnis TYPE p LENGTH 16 DECIMALS 2.

TYPES tf_erg TYPE p LENGTH 16 DECIMALS 2.

CLASS lcl_calc DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS calc_perc
        IMPORTING
          if_int1 TYPE i
          if_int2 TYPE i
        RETURNING VALUE(rf_erg) TYPE tf_erg
        RAISING cx_sy_zerodivide.
ENDCLASS.

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
    TRY.
    gf_ergebnis = zbd030_22yy_comp=>calc_perc(
      EXPORTING
        if_int1     = p_int1
        if_int2     = p_int2
        ).
    CATCH cx_sy_zerodivide .
      WRITE: : / 'Prozent von Null ist nicht erlaubt!!'(prz).
      RETURN.
  ENDTRY.

    TRY.
      gf_ergebnis = lcl_calc=>calc_perc(
        if_int1 = p_int1
        if_int2 = p_int2 ).
    CATCH cx_sy_zerodivide.
    ENDTRY.

  WHEN OTHERS.
    WRITE: / p_op, 'ist ungültiger Operator'(002).
    RETURN.
ENDCASE.

WRITE: 'Das Ergebnis ist: '(003), gf_ergebnis.

Class lcl_calc IMPLEMENTATION.
  METHOD calc_perc.
    IF  if_int2 = 0.
      RAISE EXCEPTION TYPE cx_sy_zerodivide.
    ELSE.
      rf_erg = if_int1 * 100 / if_int2.

    ENDIF.
  ENDMETHOD.
ENDCLASS.
