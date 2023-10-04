function slices=backwards(slices)

if iscell(slices{1})
  for i=1:numel(slices)
    slices{i}=backwards(slices{i});
  end
  return
end

for i=1:numel(slices)
  slices{i}=slices{i}(end:-1:1,:);
end
