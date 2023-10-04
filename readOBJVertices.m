function v=readOBJVertices(filename)

fid=fopen(filename);

v=[];

l=0;
while l!=-1
  l=fgetl(fid);
  if numel(l)>2 && strcmp(l(1:2),'v ')
    v(end+1,1:3)=eval(['[' l(2:end) ']']);
  end
end

fclose(fid);
