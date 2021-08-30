class ZBD030_22YY_COMP definition
  public
  final
  create public .

public section.

  class-methods CALC_PERC
    importing
      !IF_INT1 type I
      !IF_INT2 type I
    returning
      value(RF_ERGEBNIS) type ZBD030_PERC
    raising
      CX_SY_ZERODIVIDE .
protected section.
private section.
ENDCLASS.



CLASS ZBD030_22YY_COMP IMPLEMENTATION.


  method CALC_PERC.
    IF if_int2 = 0.
      Raise EXCEPTION TYPE CX_SY_ZERODIVIDE.
    ELSE.
      rf_ergebnis = if_int1 * 100 / if_int2.
    ENDIF.
  endmethod.
ENDCLASS.
