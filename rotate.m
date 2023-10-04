function slices=rotate(slices,rot)

if iscell(slices{1})
  for i=1:numel(slices)
    slices{i}=rotate(slices{i},rot);
  end
  return
end

for i=1:numel(slices)
  slices{i}=slices{i}*rot;
end
