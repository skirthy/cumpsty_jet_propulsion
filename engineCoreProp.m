# ==============================================================================
# GIVEN:
#   1. ENGINE CRUISE ALTITUDE AND MACH NO.
#   2. TURBINE INLET TEMPERATURE
#   3. FAN AND COMPRESSOR PRESSURE RATIOS IN THE CORE STREAM
# CALCULATE:
#   1. ENGINE CORE PROPERTIES UPTO HP TURBINE EXIT (LP TURBINE ENTRY)
# ------------------------------------------------------------------------------
# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 73, Exercise 7.1.
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 03/03/2026
# ==============================================================================

clear all
close all
clc

# ----------------- Given design / operational parameters ----------------------

cruiseMachNo              = 0.85;   # Aircraft cruise mach number
cruiseAltitude            = 31000;  # Aircraft cruise altitude (ft)
turbineInletTemp          = 1450;   # Turbine inlet temperature (combustor exit) (K)
presRatioCoreFan          = 1.6;    # Fan pressure ratio in the core stream
presRatioCoreComp         = 25;     # Compressor pressure ratio in the core stream

effFan                    = 0.9;    # Fan isentropic efficiency
effCompressor             = 0.9;    # Compressor isentropic efficiency
effCombustor              = 1.0;    # Combustor efficiency
effTurbine                = 0.9;    # Turbine isentropic efficiency
effNozzle                 = 1.0;    # Nozzle isentropic efficiency

# ---------------- ISA properties at the given altitude ------------------------

gasProp                   = isaPropFromAltitude(cruiseAltitude);

# ---------------- Engine design/operational parameters ------------------------

##engine.bypRatio           = 10;                 # Bypass ratio
engine.bypStations        = [2,13,19];          # Bypass stations
engine.coreStations       = [2,23,3,4,45,5,9];  # Core stations

engine.altCruise          = cruiseAltitude;
engine.machNo             = cruiseMachNo;
engine.velCruise          = cruiseMachNo*(gasProp.sosSI);

engine.eff013to02         = effFan;         # Fan bypass isentropic efficiency
engine.eff019to013        = effNozzle;      # Bypass nozzle isentropic efficiency
engine.eff023to02         = effFan;         # Fan core isentropic efficiency
engine.eff03to023         = effCompressor;  # Compressor isentropic efficiency
engine.eff04to03          = effCombustor;   # Combustor efficiency
engine.eff045to04         = effTurbine;     # HP turbine isentropic efficiency
engine.eff05to045         = effTurbine;     # LP turbine isentropic efficiency
engine.eff09to05          = effNozzle;      # Nozzle isentropic efficiency

# --------------------- Working gas (air) properties ---------------------------

gasProp.const             = 287;    # Gas constant for air
gasProp.gamma             = 1.4;    # Ratio of specific heat capacities (Cp/Cv)
gasProp.cp                = 1005;   # Cp value for air (J/kg/K)

# -------------------- Static properties at fan entry --------------------------

staticProp.temp2          = gasProp.tempSI;           # Static temperature (K)
staticProp.pres2          = (1/1000)*gasProp.presSI;  # Static pressure (kPa)

# ----------- Stagnation properties at fan entry (core and bypass) -------------

stationNum          = 2;
stagProp            = stagPropFromStaticProp(staticProp,engine,gasProp,stationNum);

# -------- Stagnation properties at fan exit / compressor entry (core) ---------

stationNum          = 23;
stagProp.PR023to02  = presRatioCoreFan;
stagProp            = stagPropFromPresRatio(stagProp,engine,gasProp,stationNum);

# ------ Stagnation properties at compressor exit / combustor entry (core) -----

stationNum          = 3;
stagProp.PR03to023  = presRatioCoreComp;
stagProp            = stagPropFromPresRatio(stagProp,engine,gasProp,stationNum);

# ----- Stagnation properties at combustor exit / HP turbine entry (core) ------

stationNum          = 4;
stagProp.temp04     = turbineInletTemp;
stagProp.pres04     = (engine.eff04to03)*(stagProp.pres03);
stagProp            = stagPropUpdateRatioDiff(stagProp,engine,gasProp,stationNum);

# ----- Stagnation properties at HP turbine exit / LP turbine entry (core) -----

stationNum          = 45;
stagProp.temp045    = stagProp.temp04-(stagProp.TD03to023);  # Core turbine extracts same work as done by the core compressor
stagProp.TR045to04  = stagProp.temp045/(stagProp.temp04);
stagProp            = stagPropFromTempRatio(stagProp,engine,gasProp,stationNum);

# ----------------- Save the calculated data as .mat file  ---------------------

save('engineCorePropValues.mat','engine','staticProp','stagProp','gasProp');

# Export HP turbine exit conditions to mat and dat files
# Add plots later
