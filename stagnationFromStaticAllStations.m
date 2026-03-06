function [stagnationPropVals] = stagnationFromStaticAllStations(staticPropVals,stagnationPropVals,engineVals,gasPropVals)

  machNoVal               = engineVals.machNo;
  gammaVal                = gasPropVals.gamma;

  staticFieldCount        = numfields(staticPropVals);
  staticFieldNames        = fieldnames(staticPropVals);

  for i=1:staticFieldCount

    staticFieldStr        = staticFieldNames{i};
    staticVal             = getfield(staticPropVals,staticFieldStr);

    if (strcmp(staticFieldStr(1:4),'temp') == 1)

      stagnationVal       = staticVal*(1+((gammaVal-1)/2)*(machNoVal^2));
      stagnationFieldStr  = strcat('temp0',staticFieldStr(5:end));

    elseif (strcmp(staticFieldStr(1:4),'pres') == 1)

      stagnationVal       = staticVal*(1+((gammaVal-1)/2)*(machNoVal^2))^(gammaVal/(gammaVal-1));
      stagnationFieldStr  = strcat('pres0',staticFieldStr(5:end));

    else

      printf('Entry contains neither static temperature or pressure! Check again.\n')

    endif

    stagnationPropVals  = setfield(stagnationPropVals,stagnationFieldStr,stagnationVal);

  endfor

endfunction
