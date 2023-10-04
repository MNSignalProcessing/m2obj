slices=funnel(32*(1+0.5*cosd((0:5:355)-7.5).^2),60,9,8,30,3,2,2.5,20,20,72);
writeSlices(slices,'longFunnel','longFunnel.obj','close');
slices=funnel(32,50,9,8,30,3,2,2.5,20,20,72);
writeSlices(slices,'stdFunnel','stdFunnel.obj','close');
