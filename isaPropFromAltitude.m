# ==============================================================================
# RETURN ISA CONDITIONS AT A GIVEN ALTITUDE FROM TABULATED DATA
# (INTERPOLATED VALUES)
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 06/03/2026
# ==============================================================================

function [isaPropVals]  = isaPropFromAltitude(altitudeVal)

if (altitudeVal >= -2000 && altitudeVal <= 60000)

  load isaTabulatedValues.mat         # Load the ISA data

  isaAltFt      = isaDataMat(:,1);    # Altitude (ft)
  isaTempK      = isaDataMat(:,4);    # Temperature (K)
  isaPresNm2    = isaDataMat(:,7);    # Pressure (N/m^2 or Pascal)
  isaRhoKgM3    = isaDataMat(:,10);   # Density (kg/m^3)
  isaSoSms      = isaDataMat(:,12);   # Speed of sound (m/s)

  # ------- Calulate interpolated property values at the given altitude --------
  isaPropVals.tempSI    = interp1(isaAltFt,isaTempK,altitudeVal,'linear');
  isaPropVals.presSI    = interp1(isaAltFt,isaPresNm2,altitudeVal,'spline');
  isaPropVals.rhoSI     = interp1(isaAltFt,isaRhoKgM3,altitudeVal,'spline');
  isaPropVals.sosSI     = interp1(isaAltFt,isaSoSms,altitudeVal,'linear');

else

  printf('Altitude value is out of the data range!\n');
  printf('Data is available between -2000 ft to 60000 ft. Please enter an altitude value in this range.\n');

  isaPropVals   = struct();

endif

endfunction
