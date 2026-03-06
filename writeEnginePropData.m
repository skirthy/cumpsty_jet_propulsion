# ==============================================================================
# WRITE CALCULATED ENGINE DATA TO FILE
# ------------------------------------------------------------------------------
# Author: Srinivas Kirthy K.
# Date: 06/03/2026
# ==============================================================================

function [] = writeEnginePropData(stagPropVals,staticPropVals,engineVals,gasPropVals)

  stagPropCell    = struct2cell(stagPropVals);
  stagPropVec     = cell2mat(stagPropCell);

  staticPropCell  = struct2cell(staticPropVals);
  staticPropVec   = cell2mat(staticPropCell);

  engineCell      = struct2cell(engineVals);
  engineVec       = cell2mat(engineCell(3:end));    # No need to write out station numbers

  gasPropCell     = struct2cell(gasPropVals);
  gasPropVec      = cell2mat(gasPropCell);

  enginePropVec   = vertcat(stagPropVec,staticPropVec,engineVec,gasPropVec);

  formatStr       = '';

  for i=(1:length(enginePropVec)-1)

    formatStr     = strcat(formatStr,'%f\t');

  endfor

  formatStr       = strcat(formatStr,'%f\n');

  fid1 = fopen('enginePropValues_vs_bypassRatio.dat','a');
  fprintf(fid1,formatStr,enginePropVec);
  fclose(fid1);

endfunction
