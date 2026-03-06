# ==============================================================================
# CALCULATE THE DIFFERENCE AND RATIO OF STAGNATION TEMPERATURE AND PRESSURE
# AT A GIVEN STATION TO THE PREVIOUS STATION
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 01/03/2026
# ==============================================================================

function [stagPropVals] = stagPropUpdateRatioDiff(stagPropVals,engineVals,gasPropVals,stationNumVal)

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

  printf('Calculating stagnation properties ratios and differences at %d to %d.\n',stationNumVal,prevStationNumVal);

  # Construct field name strings for stagnation properties struct
  stationStr            = strcat('0',num2str(stationNumVal));
  prevStationStr        = strcat('0',num2str(prevStationNumVal));

  stationChangeStr      = strcat(stationStr,'to',prevStationStr);

  presStationStr        = strcat('pres',stationStr);
  tempStationStr        = strcat('temp',stationStr);
  presPrevStationStr    = strcat('pres',prevStationStr);
  tempPrevStationStr    = strcat('temp',prevStationStr);

  presRatioStr          = strcat('PR',stationChangeStr);
  tempRatioStr          = strcat('TR',stationChangeStr);
  presDiffStr           = strcat('PD',stationChangeStr);
  tempDiffStr           = strcat('TD',stationChangeStr);

  # Read pressure, temperature values from previous station
  presPrevStationVal    = getfield(stagPropVals,presPrevStationStr);
  tempPrevStationVal    = getfield(stagPropVals,tempPrevStationStr);

  # Read pressure, temperature values from present station
  presStationVal        = getfield(stagPropVals,presStationStr);
  tempStationVal        = getfield(stagPropVals,tempStationStr);

  # Calculate pressure and temperature difference
  presDiffVal           = presStationVal-presPrevStationVal;
  tempDiffVal           = tempStationVal-tempPrevStationVal;

  # Calculate pressure and temperature ratio
  presRatioVal          = presStationVal/presPrevStationVal;
  tempRatioVal          = tempStationVal/tempPrevStationVal;

  # Assign the calculated values to the stagnation properties struct
  stagPropVals          = setfield(stagPropVals,presRatioStr,presRatioVal);
  stagPropVals          = setfield(stagPropVals,tempRatioStr,tempRatioVal);
  stagPropVals          = setfield(stagPropVals,presDiffStr,presDiffVal);
  stagPropVals          = setfield(stagPropVals,tempDiffStr,tempDiffVal);

endfunction
