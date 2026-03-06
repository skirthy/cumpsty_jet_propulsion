# ==============================================================================
# CALCULATE JET EXIT VELOCITIES (CORE AND BYPASS) FOR A GIVEN FAN PRESSURE RATIO
# IN THE BYPASS STREAM
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 02/03/2026
# ==============================================================================

function [stagPropStruct,engineStruct] = velJetDiffFromPresRatioBypFan(stagPropStruct,staticPropStruct,engineStruct,gasPropStruct)

  # ------ Stagnation properties at fan exit / compressor entry (bypass) -------

  stationNum                = 13;
##  stagPropStruct.PR013to02  = presRatioBypFan;
  stagPropStruct            = stagPropFromPresRatio(stagPropStruct,engineStruct,gasPropStruct,stationNum);

  # ----- Stagnation properties at LP turbine exit / nozzle entry (core) -------

  stationNum                = 5;
  stagPropStruct.temp05     = stagPropStruct.temp045-(stagPropStruct.TD023to02) ...
                              -((engineStruct.bypRatio)*(stagPropStruct.TD013to02));

  stagPropStruct.TR05to045  = stagPropStruct.temp05/(stagPropStruct.temp045);
  stagPropStruct            = stagPropFromTempRatio(stagPropStruct,engineStruct,gasPropStruct,stationNum);

  # --------------- Stagnation properties at nozzle exit (core) ----------------

  stationNum                = 9;
  stagPropStruct.PR09to05   = staticPropStruct.pres2/(stagPropStruct.pres05);
  stagPropStruct            = stagPropFromPresRatio(stagPropStruct,engineStruct,gasPropStruct,stationNum);

  # -------------- Stagnation properties at nozzle exit (bypass) ---------------

  stationNum                = 19;
  stagPropStruct.PR019to013 = staticPropStruct.pres2/(stagPropStruct.pres013);
  stagPropStruct            = stagPropFromPresRatio(stagPropStruct,engineStruct,gasPropStruct,stationNum);

  # ------------------ Jet exit velocities (core and bypass) -------------------

  tempDropNozzleCore  = -(stagPropStruct.TD09to05);
  tempDropNozzleByp   = -(stagPropStruct.TD019to013);

  velJetCoreVal       = sqrt(2*(gasPropStruct.cp)*tempDropNozzleCore);
  velJetBypVal        = sqrt(2*(gasPropStruct.cp)*tempDropNozzleByp);

  engineStruct        = setfield(engineStruct,'velJetCore',velJetCoreVal);
  engineStruct        = setfield(engineStruct,'velJetByp',velJetBypVal);

  velJetDiffVal       = velJetCoreVal-velJetBypVal;

  printf('Difference between core jet and bypass jet velocities is %f\n',velJetDiffVal);

endfunction
