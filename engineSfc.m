# ==============================================================================
# CALCULATE ENGINE SFC
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 04/03/2026
# ==============================================================================

function [engineVals] = engineSfc(engineVals)

  effOverallVal = engineVals.effOverall;  # Engine overall efficiency
  velCruiseVal  = engineVals.velCruise;   # Cruise velocity (m/s)
  fuelLCVVal    = engineVals.fuelLCV;     # Fuel LCV (MJ/kg)

  # ----------------------- Propulsive efficiency ------------------------------

  sfcVal        = (1/effOverallVal)*(velCruiseVal/fuelLCVVal)*(0.36/9.81);  # kg/s/kg-f

  engineVals    = setfield(engineVals,'sfc',sfcVal);

endfunction
