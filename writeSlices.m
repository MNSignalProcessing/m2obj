function [data,numv]=writeSlices(slices,objname,filename,opt,voffs)
% function [data,numv]=writeSlices(slices,objname,filename,opt,voffs)

if nargin<3, filename=[objname '.obj']; end
if nargin<4, opt=''; end
if nargin<5, voffs=0; end

if iscell(slices{1})
  data={};
  numv=0;
  for i=1:numel(slices)
    if iscell(opt)
      [d,nv]=writeSlices(slices{i},[objname '.' num2str(i)],'',opt{min(i,end)},numv);
    else
      [d,nv]=writeSlices(slices{i},[objname '.' num2str(i)],'',opt,numv);
    end
    numv=numv+nv;
    data={data{:} d{:}};
  end
  if ~isempty(filename)
    fid=fopen(filename,'w');
    fwrite(fid,cell2mat(data));
    fclose(fid);
  end
  return
end

npt=1;
datafill=0;
data=cell(1,100000); % just to test

% find out number of points in one slice
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

nl=sprintf('\n');

% write object name
data{++datafill}=['o ' objname nl];

% number of slices
nsl=numel(slices);

numv=0;
for i=1:nsl
  for j=1:size(slices{i},1)
    data{++datafill}=['v ' num2str(slices{i}(j,:)) nl];
    numv++;
  end
end

data{++datafill}=['s off' nl];

if size(slices{1},1)==1
  i=0;
  for j=0:npt-1
    data{++datafill}=['f ' num2str(voffs+[1, j+1 + i*npt+1, mod(j+1,npt)+1 + i*npt+1]) nl];
  end
  for i=1:nsl-3
    for j=0:npt-1
      data{++datafill}=['f ' num2str(voffs+[mod(j+1,npt)+1 + (i-1)*npt+1, j+1 + (i-1)*npt+1, j+1 + i*npt+1, mod(j+1,npt)+1 + i*npt+1]) nl];
    end
  end
  i=nsl-2;
  if size(slices{end},1)==1
    for j=0:npt-1
      data{++datafill}=['f ' num2str(voffs+[mod(j+1,npt)+1 + (i-1)*npt+1, j+1 + (i-1)*npt+1, i*npt+2]) nl];
    end
  else
    for j=0:npt-1
      data{++datafill}=['f ' num2str(voffs+[mod(j+1,npt)+1 + (i-1)*npt+1, j+1 + (i-1)*npt+1, j+1 + i*npt+1, mod(j+1,npt)+1 + i*npt+1]) nl];
    end
  end
else
  for i=0:nsl-2
    for j=0:npt-1
      data{++datafill}=['f ' num2str(voffs+[mod(j+1,npt)+1 + i*npt, j+1 + i*npt, j+1 + (i+1)*npt, mod(j+1,npt)+1 + (i+1)*npt]) nl];
    end
  end
  if strfind(opt,'close')
    i=nsl-1;
    if strfind(opt,'twist')
      for j=0:npt-1
        data{++datafill}=['f ' num2str(voffs+[mod(j+1,npt)+1 + i*npt, j+1 + i*npt, mod(j+npt/2,npt)+1, mod(j+npt/2+1,npt)+1]) nl];
      end
    else
      for j=0:npt-1
        data{++datafill}=['f ' num2str(voffs+[mod(j+1,npt)+1 + i*npt, j+1 + i*npt, j+1, mod(j+1,npt)+1]) nl];
      end
    end
  elseif strfind(opt,'cap')
    n=numAfterToken(opt,'cap');
    if isnan(n)
      data{++datafill}=['f ' num2str(voffs+(1:npt)) nl];
      data{++datafill}=['f ' num2str(voffs+(nsl-1)*npt+(npt:-1:1)) nl];
    else
      for j=1:npt/2-1
        data{++datafill}=['f ' num2str(voffs               + mod([n+j+[-1 0] n-j+[-1 0]],npt)+1) nl];
        data{++datafill}=['f ' num2str(voffs + (nsl-1)*npt + mod([n+j+[0 -1] n-j+[0 -1]],npt)+1) nl];
      end
    end
  end
end

data=data(1:datafill);

if ~isempty(filename)
  fid=fopen(filename,'w');
  fwrite(fid,cell2mat(data));
  fclose(fid);
end
