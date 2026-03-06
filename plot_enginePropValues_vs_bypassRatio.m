# ==============================================================================
# PLOT CALCULATED ENGINE PERFORMANCE FIGURES VS BYPASS RATIO
# ------------------------------------------------------------------------------
# Nicholas Cumpsty, Jet propulsion (2005), Cambridge University Press.
# Page 73, Exercise 7.1.
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 06/03/2026
# ==============================================================================

clear all
close all
clc

engineData  = importdata('enginePropValues_vs_bypassRatio.dat');

engineBypRatio            = engineData(:,64);
engineGrossThrustSpec     = engineData(:,68);
engineNetThrustSpec       = engineData(:,69);
engineEffOverall          = engineData(:,72);
engineSfc                 = engineData(:,73);

figure(1)
grid on
hold on
[hax, h1, h2] = plotyy(engineBypRatio,engineGrossThrustSpec,engineBypRatio,engineNetThrustSpec)
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Bypass ratio','Fontsize',24)
ylabel(hax(1),'Gross thrust per air mass (kN/kg/s)','Fontsize',24)
ylabel(hax(2),'Net thrust per air mass (kN/kg/s)','Fontsize',24)

figure(2)
grid on
hold on
[hax, h1, h2] = plotyy(engineBypRatio,engineEffOverall,engineBypRatio,engineSfc)
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Bypass ratio','Fontsize',24)
ylabel(hax(1),'Overall efficiency','Fontsize',24)
ylabel(hax(2),'Sfc (kg/s/kg-f)','Fontsize',24)
