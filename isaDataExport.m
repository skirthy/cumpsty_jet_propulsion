# ==============================================================================
# READ INTERNATIONAL STANDARD ATMPOSPHERE (ISA) TABULATED VALUES FROM
# SPREADSHEET, CHECK FOR CORRECTNESS AND SAVE THEM AS DAT AND MAT FILES
# ------------------------------------------------------------------------------
# Data extracted from:
# Trevor M. Young, Performance of the Jet Transport Airplane: Analysis Methods,
# Flight Operations, and Regulations (2018), John Wiley & Sons.,
# Page 583, Appendix A.
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 02/03/2026
# ==============================================================================

clear all
close all
clc

# ------------------- Read ISA data from spreadsheet ---------------------------

##pkg load io
##isaDataMat    = xlsread('ISA_tabulated_values.ods');

# --------------------- Save ISA data as .mat file -----------------------------

##save('isaTabulatedValues.mat','isaDataMat');

# --------------------- Save ISA data as .dat file -----------------------------

##fid1 = fopen('isaTabulatedValues.dat','w');
##fprintf(fid1,'%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',isaDataMat');
##fclose(fid1);

# -------------------- Load ISA data from .dat file ----------------------------

##isaDataFromFile = importdata('isaTabulatedValues.dat');

# -------------------- Load ISA data from .mat file ----------------------------

load isaTabulatedValues.mat

isaAltFt      = isaDataMat(:,1);
isaAltMt      = isaDataMat(:,2);
isaTheta      = isaDataMat(:,3);
isaTempK      = isaDataMat(:,4);
isaTempC      = isaDataMat(:,5);
isaDelta      = isaDataMat(:,6);
isaPresNm2    = isaDataMat(:,7);
isaPresLbFt2  = isaDataMat(:,8);
isaSigma      = isaDataMat(:,9);
isaRhoKgM3    = isaDataMat(:,10);
isaRhoSlFt3   = isaDataMat(:,11);
isaSoSms      = isaDataMat(:,12);
isaSoSfts     = isaDataMat(:,13);
isaSoSkt      = isaDataMat(:,14);

isaAltFtDiff  = diff(isaAltFt);

[idx] = find(isaAltFtDiff != 200);

if (isempty(idx))

   printf('Checked, all okay!\nAll altitude values are in increments of 200 ft.\n');

else

   printf('Erroneous entries detected!\n');
   printf('Check row %d\n',idx);

endif

figure(1)
plot(isaAltFt,isaAltMt,'Linewidth',2)
grid on
set(gca,'Fontsize',20)
xlabel('Altitude (ft)','Fontsize',24)
ylabel('Altitude (m)','Fontsize',24)

figure(2)
[hax, h1, h2] = plotyy(isaAltFt,isaTempK,isaAltFt,isaTempC);
grid on
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Altitude (ft)','Fontsize',24)
ylabel(hax(1),'Temperature (K)','Fontsize',24)
ylabel(hax(2),'Temperature (^oC)','Fontsize',24)

figure(3)
set(gca,'Fontsize',20)
[hax, h1, h2] = plotyy(isaAltFt,isaTheta,isaAltFt,isaDelta);
grid on
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Altitude (ft)','Fontsize',24)
ylabel(hax(1),'\theta','Fontsize',24)
ylabel(hax(2),'\delta','Fontsize',24)

figure(4)
[hax, h1, h2] = plotyy(isaAltFt,isaPresNm2,isaAltFt,isaPresLbFt2);
grid on
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Altitude (ft)','Fontsize',24)
ylabel(hax(1),'Pressure (N/m^2)','Fontsize',24)
ylabel(hax(2),'Pressure (lb/ft^2)','Fontsize',24)

figure(5)
[hax, h1, h2] = plotyy(isaAltFt,isaRhoKgM3,isaAltFt,isaRhoSlFt3);
grid on
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Altitude (ft)','Fontsize',24)
ylabel(hax(1),'\rho (Kg/m^3)','Fontsize',24)
ylabel(hax(2),'\rho (slug/ft^3)','Fontsize',24)

figure(6)
[hax, h1, h2] = plotyy(isaAltFt,isaSoSms,isaAltFt,isaSoSfts);
grid on
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Altitude (ft)','Fontsize',24)
ylabel(hax(1),'Speed of sound (m/s)','Fontsize',24)
ylabel(hax(2),'Speed of sound (ft/s)','Fontsize',24)

figure(7)
[hax, h1, h2] = plotyy(isaAltFt,isaSoSkt,isaAltFt,isaSigma);
grid on
set(hax,'Fontsize',20)
set([h1],'Linewidth',2)
set([h2],'Linewidth',2)
xlabel('Altitude (ft)','Fontsize',24)
ylabel(hax(1),'Speed of sound (knots)','Fontsize',24)
ylabel(hax(2),'\sigma','Fontsize',24)
