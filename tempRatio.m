function [tempRatioVal] = tempRatio(presRatioVal, effComponent, gammaVal)

  if (presRatioVal >= 1)     # For fans and compressors
##    printf("Fan or Compressor\n")
    tempRatioVal = (1+(1/effComponent)*(presRatioVal.^((gammaVal-1)/gammaVal)-1));
  else                    # For turbines
##    printf("Turbine\n")
    tempRatioVal = (1-effComponent*(1-presRatioVal.^((gammaVal-1)/gammaVal)));
  endif

end
