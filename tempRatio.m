function [tempRatioVal] = tempRatio(presRatio, effComponent, gammaVal)

  if (presRatio >= 1)     # For fans and compressors
    printf("Fan or Compressor\n")
    tempRatioVal = (1+(1/effComponent)*(presRatio.^((gammaVal-1)/gammaVal)-1));
  else                    # For turbines
    printf("Turbine\n")
    tempRatioVal = (1-effComponent*(1-presRatio.^((gammaVal-1)/gammaVal)));
  endif

end
