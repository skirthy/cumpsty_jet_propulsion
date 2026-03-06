# ==============================================================================
# CALCULATE STAGNATION TEMPERATURE, PRESSURE, THEIR DIFFERENCES AND RATIOS AT
# A GIVEN STATION FROM THE STAGNATION TEMPERATURE RATIO
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 02/03/2026
# ==============================================================================

function [stagPropVals] = stagPropFromTempRatio(stagPropVals,engineVals,gasPropVals,stationNumVal)

  gammaVal              = gasPropVals.gamma;
  coreStationVals       = engineVals.coreStations;
  bypStationVals        = engineVals.bypStations;

  # Find the station number index in core or bypass stations
  coreStationIdxVal     = find(coreStationVals == stationNumVal);
  bypStationIdxVal      = find(bypStationVals == stationNumVal);

  # Check if the station number belongs to core stations
  if (isfinite(coreStationIdxVal) && isempty(bypStationIdxVal))

    prevStationNumVal   = coreStationVals(coreStationIdxVal-1);

  # Check if the station number belongs to bypass stations
  elseif (isfinite(bypStationIdxVal) && isempty(coreStationIdxVal))

    prevStationNumVal   = bypStationVals(bypStationIdxVal-1);

  endif

  printf('Calculating stagnation properties at %d from %d.\n',stationNumVal,prevStationNumVal);

  # Construct field name strings for stagnation properties struct
  stationStr            = strcat('0',num2str(stationNumVal));
  prevStationStr        = strcat('0',num2str(prevStationNumVal));

  stationChangeStr      = strcat(stationStr,'to',prevStationStr);

  presStationStr        = strcat('pres',stationStr);
  tempStationStr        = strcat('temp',stationStr);
  presPrevStationStr    = strcat('pres',prevStationStr);
  tempPrevStationStr    = strcat('temp',prevStationStr);

  effComponentStr       = strcat('eff',stationChangeStr);
  presRatioStr          = strcat('PR',stationChangeStr);
  tempRatioStr          = strcat('TR',stationChangeStr);
  presDiffStr           = strcat('PD',stationChangeStr);
  tempDiffStr           = strcat('TD',stationChangeStr);

  # Read pressure, temperature values from previous station
  presPrevStationVal    = getfield(stagPropVals,presPrevStationStr);
  tempPrevStationVal    = getfield(stagPropVals,tempPrevStationStr);

  # Read efficiency of the relevant component and pressure ratio across the stations
  effComponentVal       = getfield(engineVals,effComponentStr);
  tempRatioVal          = getfield(stagPropVals,tempRatioStr);

  # Calculate temperature ratio from pressure ratio
  presRatioVal          = presRatioFromTempRatio(tempRatioVal,effComponentVal,gammaVal);

  # Calulate stagnation pressure at the present station
  presStationVal        = presPrevStationVal*presRatioVal;
  tempStationVal        = getfield(stagPropVals,tempStationStr);

  # Calculate pressure and temperature difference
  presDiffVal           = presStationVal-presPrevStationVal;
  tempDiffVal           = tempStationVal-tempPrevStationVal;

  # Assign the calculated values to the stagnation properties struct
  stagPropVals          = setfield(stagPropVals,presStationStr,presStationVal);

  stagPropVals          = setfield(stagPropVals,presRatioStr,presRatioVal);
  stagPropVals          = setfield(stagPropVals,presDiffStr,presDiffVal);
  stagPropVals          = setfield(stagPropVals,tempDiffStr,tempDiffVal);

endfunction
