# ==============================================================================
# CALCULATE STAGNATION TEMPERATURE AND PRESSURE FROM THE
# CORRESPONDING STATIC VALUES AND MACH NUMBER
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 03/03/2026
# ==============================================================================

function [stagPropVals] = stagPropFromStaticProp(staticPropVals,engineVals,gasPropVals,stationNumVal)

  machNoVal         = engineVals.machNo;
  gammaVal          = gasPropVals.gamma;

  staticPropCount   = numfields(staticPropVals);
  staticPropNames   = fieldnames(staticPropVals);

  # Define empty struct for stagnation properties
  stagPropVals      = struct();

  # Find all static properties and calculate corresponding stagnation properties
  for i=1:staticPropCount

    staticPropStr   = staticPropNames{i};
    staticVal       = getfield(staticPropVals,staticPropStr);

    # If the static property is temperature
    if (strcmp(staticPropStr,strcat('temp',num2str(stationNumVal))) == 1)

      stagVal       = staticVal*(1+((gammaVal-1)/2)*(machNoVal^2));
      stagPropStr   = strcat('temp0',staticPropStr(5:end))

    # If the static property is pressure
    elseif (strcmp(staticPropStr,strcat('pres',num2str(stationNumVal))) == 1)

      stagVal       = staticVal*(1+((gammaVal-1)/2)*(machNoVal^2))^(gammaVal/(gammaVal-1));
      stagPropStr   = strcat('pres0',staticPropStr(5:end))

    else

      printf('No entry found for static temperature or pressure at station %d! Check again.\n',stationNumVal);
      return;

    endif

    # Assign the calculated stagnation value to the stagnation properties struct
    stagPropVals    = setfield(stagPropVals,stagPropStr,stagVal);

  endfor

endfunction
