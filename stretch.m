function slices=stretch(slices,factors)

if iscell(slices{1})
  for i=1:numel(slices)
    slices{i}=stretch(slices{i},factors);
  end
  return
end

for i=1:numel(slices)
  slices{i}=slices{i}.*(ones(size(slices{i},1),1)*factors);
end
