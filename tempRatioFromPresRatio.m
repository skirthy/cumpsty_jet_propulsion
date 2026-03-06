# ==============================================================================
# CALCULATE STAGNATION TEMPERATURE RATIO FROM STAGNATION PRESSURE RATIO
# AT A GIVEN STATION
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 01/03/2026
# ==============================================================================

function [tempRatio] = tempRatioFromPresRatio(presRatio,effComponent,gammaGas)

  if (presRatio >= 1)     # For fans and compressors
##    printf("Fan or Compressor\n")
    tempRatio = (1+(1/effComponent)*(presRatio.^((gammaGas-1)/gammaGas)-1));
  else                    # For turbines
##    printf("Turbine\n")
    tempRatio = (1-effComponent*(1-presRatio.^((gammaGas-1)/gammaGas)));
  endif

endfunction
