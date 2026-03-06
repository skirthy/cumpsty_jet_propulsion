# ==============================================================================
# CALCULATE SPEED OF SOUND AT A GIVEN TEMPERATURE FOR GIVEN GAS PROPERTIES
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 02/03/2026
# ==============================================================================

function [soundSpeedVal] = speedOfSound(gasPropVals,tempVal)

  gammaVal      = gasPropVals.gamma;
  constVal      = gasPropVals.const;

  soundSpeedVal = sqrt(gammaVal*constVal*tempVal);

endfunction
