function [presRatioVal] = presRatio(tempRatioVal, effComponent, gammaVal)

  if (tempRatioVal >= 1)     # For fans and compressors
##    printf("Fan or Compressor\n")
    presRatioVal = (1+effComponent*(tempRatioVal-1)).^(gammaVal/(gammaVal-1));
  else          # For turbines
##    printf("Turbine\n")
    presRatioVal = (1-(1/effComponent)*(1-tempRatioVal)).^(gammaVal/(gammaVal-1));
  endif

end
