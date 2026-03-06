# ==============================================================================
# CALCULATE ENGINE GROSS THRUST PER UNIT CORE MASS FLOW RATE
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 02/03/2026
# ==============================================================================

function [engineVals] = engineThrustGross(engineVals)

  bypRatioVal     = engineVals.bypRatio;
  velJetVal       = engineVals.velJetCore;

  # --------------- Gross thrust per unit core mass flow rate ------------------

  thrustGrossVal  = ((1+bypRatioVal)*velJetVal)/1000;     # Gross thrust (kN)

  engineVals      = setfield(engineVals,'TgrossPerCoreMdot',thrustGrossVal);

endfunction
