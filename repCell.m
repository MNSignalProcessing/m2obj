function rc=repCell(r,c)

rc=cell(1,r);
for i=1:r
  rc{i}=c{mod(i-1,numel(c))+1};
end
