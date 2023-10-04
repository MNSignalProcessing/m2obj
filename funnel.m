function slices=funnel(topd,toph,centd,botd,both,slh,sled,wall,handlelen,handleang,numslices)

% function slices=funnel(topd,toph,centd,botd,both,slh,sled,wall,handlelen,handleang,numslices)
%
% Inputs:
%   topd       diameter at top
%   toph       height of top part
%   centd      diameter at center
%   botd       diameter at bottom
%   both       height of bottom part
%   slh        height of sloped end of bottom part
%   sled       height difference at edge of sloped end
%   wall       wall thickness
%   handlelen  length of handle
%   handleang  angle of handle
%   numslices  number of slices

slices={};

topd_=topd;

for i=1:numslices
  if numel(topd_)>=i
    topd=topd_(i);
  end
  angle=i/numslices*360;
  xy=[cos(2*pi*(i-1)/numslices),sin(2*pi*(i-1)/numslices)];
  if angle<=handleang
    slices{i}=[topd*xy,0
               (topd+wall+handlelen)*xy,0
               (topd+wall+handlelen)*xy,wall
               (topd+wall)*xy,wall
               (centd+wall)*xy,toph
               (botd+wall)*xy,toph+both-cosd(angle-handleang/2)*slh/2
               botd*xy,toph+both-cosd(angle-handleang/2)*slh/2+sled
               centd*xy,toph
               topd*xy,wall
              ];
  else
    slices{i}=[topd*xy,0
               (topd+wall)*xy,0
               (topd+wall)*xy,wall
               (topd+wall)*xy,wall
               (centd+wall)*xy,toph
               (botd+wall)*xy,toph+both-cosd(angle-handleang/2)*slh/2
               botd*xy,toph+both-cosd(angle-handleang/2)*slh/2+sled
               centd*xy,toph
               topd*xy,wall
              ];
  end
end
