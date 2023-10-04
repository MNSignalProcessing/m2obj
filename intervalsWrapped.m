function ii=intervalsWrapped(lidx)
% function ii=intervalsWrapped(lidx)
%
% lidx  logical index
%
% ii    cell array with index intervals

ii={};
i=1;

while i<=numel(lidx)
  iii=[];
  while i<=numel(lidx) && lidx(i)
    iii(end+1)=i;
    i=i+1;
  end
  ii{end+1}=iii;
  while i<=numel(lidx) && ~lidx(i)
    i=i+1;
  end
end

if numel(ii{1})==0
  ii=ii(2:end);
end

if numel(ii)>1 && ii{1}(1)==1 && ii{end}(end)==numel(lidx)
  ii{1}=[ii{end} ii{1}];
  ii=ii(1:end-1);
end
