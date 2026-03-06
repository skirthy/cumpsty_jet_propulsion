# ==============================================================================
# CALCULATE ENGINE THERMAL EFFICIENCY
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 03/03/2026
# ==============================================================================

function [engineVals] = engineEffThermal(stagPropVals,staticPropVals,engineVals,gasPropVals)

  cpVal         = gasPropVals.cp;

  bypRatioVal   = engineVals.bypRatio;

  temp2Val      = staticPropVals.temp2;

  temp02Val     = stagPropVals.temp02;
  temp03Val     = stagPropVals.temp03;
  temp04Val     = stagPropVals.temp04;
  temp05Val     = stagPropVals.temp05;
  temp09Val     = stagPropVals.temp09;

  # ------------------------- Thermal efficiency -------------------------------

  effThermVal   = (1+bypRatioVal)*((temp05Val-temp09Val)-(temp02Val-temp2Val))/(temp04Val-temp03Val);

  engineVals    = setfield(engineVals,'effTherm',effThermVal);

endfunction
