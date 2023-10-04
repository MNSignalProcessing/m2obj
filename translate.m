function slices=translate(slices,offsets)

if iscell(slices{1})
  for i=1:numel(slices)
    slices{i}=translate(slices{i},offsets);
  end
  return
end

for i=1:numel(slices)
  slices{i}=slices{i}+(ones(size(slices{i},1),1)*offsets);
end
