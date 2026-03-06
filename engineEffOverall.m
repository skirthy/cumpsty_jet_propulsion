# ==============================================================================
# CALCULATE ENGINE OVERALL EFFICIENCY
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 03/03/2026
# ==============================================================================

function [engineVals] = engineEffOverall(stagPropVals,engineVals,gasPropVals)

  cpVal         = gasPropVals.cp;

  temp03Val     = stagPropVals.temp03;
  temp04Val     = stagPropVals.temp04;

  velCruiseVal  = engineVals.velCruise;
  thrustNetVal  = 1000*(engineVals.TnetPerCoreMdot);  # Convert kN to N

  workEngineVal = thrustNetVal*velCruiseVal;    # Work done by the engine thrust force

  heatAddedVal  = cpVal*(temp04Val-temp03Val);  # Heat added in the combustor

  # ------------------------- Overall efficiency -------------------------------

  effOverallVal = workEngineVal/heatAddedVal;

  engineVals    = setfield(engineVals,'effOverall',effOverallVal);

endfunction
