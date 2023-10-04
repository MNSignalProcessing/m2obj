function msl=displaySlices(slices,opt)

if nargin<2, opt=''; end

if iscell(slices{1})
  for i=1:numel(slices)
    if i>1, hold on; end
    displaySlices(slices{i},opt);
  end
  return
end

npt=1;

if size(slices{1},1)!=size(slices{end},1)
  error(['Number of points in first (' num2str(size(slices{1},1)) ') and last (' num2str(size(slices{end},1)) ') slice must be equal']);
end
for i=1:numel(slices)
  n=size(slices{i},1);
  if i>1 && i<numel(slices) && n==1
    error('only the first and the last slice may contain a single point');
  end
  if n>1
    if npt>1 && n!=npt
      if i==numel(slices)
        error(['At slice nr. ' num2str(i) ' number of points was ' num2str(n) ' (expected: 1 or ' num2str(npt) ')']);
      else
        error(['At slice nr. ' num2str(i) ' number of points was ' num2str(n) ' (expected: ' num2str(npt) ')']);
      end
    end
    npt=n;
  end
end

for i=1:numel(slices)
  plot3(slices{i}([1:end,1],1),slices{i}([1:end,1],2),slices{i}([1:end,1],3));
  if size(slices{i},1)==1
    slices{i}=ones(npt,1)*slices{i};
  end
  hold on
end

msl=cell2mat(slices(:)');

if strfind(opt,'close')
  if strfind(opt,'twist')
    msl=[msl,msl([end/2+1:end 1:end/2],1:3)];
  else
    msl=[msl,msl(:,1:3)];
  end
end
plot3(msl(:,1:3:end)',msl(:,2:3:end)',msl(:,3:3:end)','k--');

hold off
axis equal
xlabel('x');
ylabel('y');
zlabel('z');
