function [presRatioVal] = presRatio(tempRatio, effComponent, gammaVal)

  if (tempRatio >= 1)     # For fans and compressors
    presRatioVal = 1./((1+effComponent*(tempRatio-1)).^(gammaVal/(gammaVal-1)));
  else                    # For turbines
    presRatioVal = 1./((1-(1/effComponent)*(1-tempRatio)).^(-gammaVal/(gammaVal-1)));
  endif

end
