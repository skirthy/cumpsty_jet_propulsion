# ==============================================================================
# CALCULATE ENGINE PROPULSIVE EFFICIENCY
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 03/03/2026
# ==============================================================================

function [engineVals] = engineEffPropulsive(engineVals)

  velCruiseVal  = engineVals.velCruise;
  velJetVal     = engineVals.velJetCore;

  # ----------------------- Propulsive efficiency ------------------------------

  effPropVal    = 2*(velCruiseVal)/(velCruiseVal+velJetVal);

  engineVals    = setfield(engineVals,'effProp',effPropVal);

endfunction
