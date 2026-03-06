# ==============================================================================
# CALCULATE ENGINE NET THRUST PER UNIT CORE MASS FLOW RATE
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 02/03/2026
# ==============================================================================

function [engineVals] = engineThrustNet(engineVals)

  bypRatioVal     = engineVals.bypRatio;
  velCruiseVal    = engineVals.velCruise;
  velJetVal       = engineVals.velJetCore;

  # --------------- Net thrust per unit core mass flow rate --------------------

  thrustNetVal    = ((1+bypRatioVal)*(velJetVal-velCruiseVal))/1000;  # Net thrust (kN)

  engineVals      = setfield(engineVals,'TnetPerCoreMdot',thrustNetVal);

endfunction
