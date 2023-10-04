function slices=cleanupSlices(slices)

idx=false(size(slices));

for i=1:numel(slices)
  idx(i)=~isempty(slices{i});
end
slices=slices(idx);
