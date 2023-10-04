function [sx,sy]=clampPolygon(tsx,tsy,minY,maxY)

[sx,sy]=clamp0(tsx,tsy-maxY);
[sx,sy]=clamp0(sx,minY-sy-maxY);
sy=minY-sy;

function [x,y]=clamp0(tx,ty)
  x=[]; y=[];
  for i=1:numel(tx)
    ip=mod(i-2,numel(tx))+1;
    in=mod(i,numel(tx))+1;
    if ty(ip)<0 && ty(i)>0 && ty(in)<0
      r1=-ty(ip)/(ty(i)-ty(ip));
      r2=-ty(in)/(ty(i)-ty(in));
      x(end+(1:2))=[tx(ip)*(1-r1)+tx(i)*r1,tx(in)*(1-r2)+tx(i)*r2];
      y(end+(1:2))=[ty(ip)*(1-r1)+ty(i)*r1,ty(in)*(1-r2)+ty(i)*r2];
    elseif ty(ip)>0 && ty(i)>0 && ty(in)>0
      x(end+1)=tx(i);
      y(end+1)=0;
    else
      x(end+1)=tx(i);
      y(end+1)=ty(i);
    end
  end
  tx=x;
  ty=y;
  x=[];
  y=[];
  for i=1:numel(tx)
    ip=mod(i-2,numel(tx))+1;
    in=mod(i,numel(tx))+1;
    if ty(ip)<0 && ty(i)>0
      r=-ty(ip)/(ty(i)-ty(ip));
      x(end+1)=[tx(ip)*(1-r)+tx(i)*r];
      y(end+1)=[ty(ip)*(1-r)+ty(i)*r];
    elseif ty(in)<=0 && ty(i)>0
      r=-ty(in)/(ty(i)-ty(in));
      x(end+1)=[tx(in)*(1-r)+tx(i)*r];
      y(end+1)=[ty(in)*(1-r)+ty(i)*r];
    else
      x(end+1)=tx(i);
      y(end+1)=ty(i);
    end
  end
  idx=abs(y)<eps;
  ii=intervalsWrapped(idx);
  for i=1:numel(ii)
    x(ii{i})=linspace(x(ii{i}(1)),x(ii{i}(end)),numel(ii{i}));
  end
end

end
