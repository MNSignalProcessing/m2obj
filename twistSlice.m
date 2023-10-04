function slices=twistSlice(slice,angles,heights)

N=max(numel(angles),numel(heights));
slices=cell(1,N);

for i=1:N
  a=angles(min(i,end));
  r=[cosd(a) sind(a);-sind(a) cosd(a)];
  h=heights(min(i,end));
  slices{i}=[slice(:,1:2)*r,slice(:,3)+h];
end
