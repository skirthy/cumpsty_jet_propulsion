# ------------------------------------------------------------------------------
# EFFECT OF BYPASS RATIO ON SOME JET ENGINE PERFORMANCE PARAMETERS

# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 73, Exercise 7.1.
#-------------------------------------------------------------------------------

clear all
close all
clc

bypRatio  = [0:9]';      # Bypass ratio
##bypRatio  = 6;      # Bypass ratio

gammaAir  = 1.4;          # Ratio of specific heat capacities (Cp/Cv)
cpAir     = 1005;

temp02    = 259.5;        # Stagnation temperature at the fan entry (at H = 31000 ft, M = 0.85) (K)
temp04    = 1450;         # Turbine inlet temperature (Temperature at the combustor exit) (K)

pres2     = 28.7;         # Static pressure at H = 31000 ft (kPa)
pres02    = 46;           # Stagnation pressure at the fan entry (kPa)

presRatio023to02  = 1.6;  # Pressure ratio across the fan
presRatio03to023  = 25;   # Pressure ratio across the core compressor

effFan            = 0.9;  # Fan isentropic efficiency
effComp           = 0.9;  # Compressor isentropic efficiency
effTurb           = 0.9;  # Turbine isentropic efficiency
effNozzle         = 1.0;  # Nozzle isentropic efficiency

# Fan exit / Compressor entry
tempRatio023to02  = tempRatio(presRatio023to02,effFan,gammaAir);
temp023           = temp02*tempRatio023to02;
pres023           = pres02*presRatio023to02;

# Compressor exit / Combustor entry
tempRatio03to023  = tempRatio(presRatio03to023,effComp,gammaAir);
temp03            = temp023*tempRatio03to023;
pres03            = pres023*presRatio03to023;

# Combustor exit / Turbine entry
pres04            = pres03;  # No pressure loss in the combustor (isentropic)

# Core turbine exit / Low pressure turbine entry
temp045           = temp04-(temp03-temp023);  # Core turbine extracts same work as done by the core compressor
tempRatio045to04  = temp045/temp04;
presRatio045to04  = presRatio(tempRatio045to04,effTurb,gammaAir);
pres045           = pres04*presRatio045to04;

# Low pressure turbine exit / Core nozzle entry
temp05            = temp045-(1+bypRatio)*(temp023-temp02)
tempRatio05to045  = temp05/temp045;
presRatio05to045  = presRatio(tempRatio05to045,effTurb,gammaAir);
pres05            = pres045*presRatio05to045
tempDiff          = temp045-temp05

# Nozzle exit
presRatio09to05   = pres2./pres05
tempRatio09to05   = tempRatio(presRatio09to05,effNozzle,gammaAir)
temp09            = temp05.*tempRatio09to05

# Exit speeds
velJet            = sqrt(2*cpAir*(temp05-temp09))

