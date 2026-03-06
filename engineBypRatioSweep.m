# ==============================================================================
# GIVEN:
#   1. BYPASS RATIO RANGE
#   2. ENGINE CORE PROPERTIES UPTO LP TURBINE ENTRY
# WITH CONDITION:
#   EQUAL JET EXIT VELOCITIES IN CORE AND BYPASS (Vjc=Vjb)
# CALCULATE:
#   1. FAN PRESSURE RATIO IN THE BYPASS STREAM
#   2. ENGINE CORE AND BYPASS PROPERTIES
#   3. ENGINE PERFORMANCE
# ------------------------------------------------------------------------------
# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 73, Exercise 7.1.
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 04/03/2026
# ==============================================================================

clear all

# ----------------- Given design / operational parameters ----------------------

bypassRatio           = [0:0.1:10];        # Engine bypass ratio
##bypassRatio           = 6;        # Engine bypass ratio
engineFuelLCV         = 43;       # Lower Calorific Value of the fuel (MJ/kg)

load engineCorePropValues.mat     # Engine core properties

for i=1:length(bypassRatio)

  close all
  clc

  # ---------------- Engine design/operational parameters ----------------------

  engine.bypRatio       = bypassRatio(i);
  engine.fuelLCV        = engineFuelLCV;

  # ------------- Calulate bypass fan pressure ratio iteratively ---------------

  stagProp.PR013to02    = 1.0;    # Fan pressure ratio in the bypass stream (initial guess)
  presRatioBypFanInc    = 0.1;    # Increments to fan pressure ratio in the bypass stream

  velJetDiff            = 1;      # Difference between core and bypass jet exit velocities
  velJetDiffTol         = 1e-10;  # Tolerance for jet velocity difference

  # ------------- Calculate Vjc and Vjb until (Vjc - Vjb) is negative ----------

  while (velJetDiff > 0 && velJetDiff < 1000)

    stagProp.PR013to02  = stagProp.PR013to02+presRatioBypFanInc;

    # ------------------------- Calculate (Vjc - Vjb) --------------------------

    [stagProp,engine]   = velJetDiffFromPresRatioBypFan(stagProp,staticProp,engine,gasProp);
    velJetDiff          = engine.velJetCore-(engine.velJetByp);

    # ------- Store fan pressure ratio values for (Vjc-Vjb=0) root finding -----

    if (velJetDiff >= 0)
      velJetDiffPos     = velJetDiff;
      presRatioPos      = stagProp.PR013to02;
    else
      velJetDiffNeg     = velJetDiff;
      presRatioNeg      = stagProp.PR013to02;
    endif

    figure(1)
    grid on
    hold on
    set(gca,'Fontsize',20)
    plot(stagProp.PR013to02,velJetDiff,'bx','Markersize',10,'Linewidth',2)
    xlabel('Fan pressure ratio','Fontsize',24)
    ylabel('V_{jc}-V_{jb} (m/s)','Fontsize',24)

  endwhile

  # ----------------- Root finding (Vjc-Vjb=0) - bisection method --------------

  iter = 0;

  while (abs(velJetDiff) > velJetDiffTol && iter < 1000)

    iter = iter+1;

    stagProp.PR013to02  = 0.5*(presRatioPos+presRatioNeg);

    # ----------------------- Calculate (Vjc - Vjb) ----------------------------

    [stagProp,engine]   = velJetDiffFromPresRatioBypFan(stagProp,staticProp,engine,gasProp);
    velJetDiff          = engine.velJetCore-(engine.velJetByp);

    if (velJetDiff >= 0)
      presRatioPos      = stagProp.PR013to02;
    else
      presRatioNeg      = stagProp.PR013to02;
    endif

  end

  printf('Velocity difference tolerance reached! \nFan pressure ratio in bypass stream is %f\n',stagProp.PR013to02)

  figure(1)
  grid on
  hold on
  set(gca,'Fontsize',20)
  plot(stagProp.PR013to02,velJetDiff,'r+','Markersize',15,'Linewidth',2)

  # ----------------------- Engine performance parameters ----------------------

  engine  = engineThrustGross(engine);
  engine  = engineThrustNet(engine);

  engine  = engineEffPropulsive(engine);
  engine  = engineEffThermal(stagProp,staticProp,engine,gasProp);
  engine  = engineEffOverall(stagProp,engine,gasProp);

  engine  = engineSfc(engine);


  # --------------------- Save calculated data as .mat file --------------------

  fileNameStrMat      = strcat('enginePropValues_bpr_',num2str(engine.bypRatio,'%3.1f'),'.mat');
  save(fileNameStrMat,'engine','staticProp','stagProp','gasProp');

  # Convert writing to file to a function here!

  writeEnginePropData(stagProp,staticProp,engine,gasProp)

endfor
