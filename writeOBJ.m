function writeOBJ(filename,v,f,o)

if ~iscell(o)
  v={v};
  f={f};
  o={o};
end

fid=fopen(filename,'w');

for i=1:numel(o)
  fprintf(fid,'o %s\n',o{i});
  for j=1:size(v{i},1)
    fprintf(fid,'v %s\n',num2str(v{i}(j,:),7));
  end
  fprintf(fid,'s off\n');
  for j=1:size(f{i},1)
    fprintf(fid,'f %s\n',num2str(f{i}(j,:)));
  end
end

fclose(fid);
