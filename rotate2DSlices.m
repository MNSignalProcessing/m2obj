function slices=rotate2DSlices(sx,sy,numslices)
% function slices=rotate2DSlices(sx,sy,numslices)
% 
% Inputs:
%   sx, sy    rotating slice. Note: if cell array is given,
%             individual cells are used until end of cell array.
%             The first sx, sy should always be identical
%             to the last to avoid discontinuities.
%   numslices number of slices for 360 degrees

if iscell(sx) && ~iscell(sy)
  sy={sy};
end

if iscell(sy) && ~iscell(sx)
  sx={sx};
end

if iscell(sx)
  slices=cell(1,max(numel(sx),numel(sy)));
else
  slices=cell(1,numslices+1);
end

for i=0:numel(slices)-1
  % set up basic shape
  if iscell(sx)
    basex=[sx{min(end,i+1)}];
  else
    basex=[sx];
  end
  if iscell(sy)
    basey=[sy{min(end,i+1)}];
  else
    basey=[sy];
  end
  % create slice
  slices{i+1}=[basex,basey*cos(2*pi*i/numslices),basey*sin(2*pi*i/numslices)];
end
