# ==============================================================================
# CALCULATE STAGNATION PRESSURE RATIO FROM STAGNATION TEMPERATURE RATIO
# AT A GIVEN STATION
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 01/03/2026
# ==============================================================================

function [presRatio] = presRatioFromTempRatio(tempRatio,effComponent,gammaGas)

  if (tempRatio >= 1)     # For fans and compressors
##    printf("Fan or Compressor\n")
    presRatio = (1+effComponent*(tempRatio-1)).^(gammaGas/(gammaGas-1));
  else          # For turbines
##    printf("Turbine\n")
    presRatio = (1-(1/effComponent)*(1-tempRatio)).^(gammaGas/(gammaGas-1));
  endif

endfunction
