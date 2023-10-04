function [v,f,o]=readOBJ(filename)

fid=fopen(filename);

v={};
f={};
o={};

l=0;
while l!=-1
  l=fgetl(fid);
  if numel(l)>2
    if strcmp(l(1:2),'o ')
      o{end+1}=l(3:end);
      v{end+1}=[];
      f{end+1}=[];
    end
    if strcmp(l(1:2),'v ')
      v{end}(end+1,1:3)=eval(['[' l(2:end) ']']);
    end
    if strcmp(l(1:2),'f ')
      l=regexprep(l,'//[0-9]+',''); % get rid of normals
      idx=eval(['[' l(2:end) ']']);
      f{end}(end+1,1:numel(idx))=idx;
    end
  end
end

fclose(fid);


