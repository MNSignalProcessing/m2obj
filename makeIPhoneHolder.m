lh1=40; % length of horizontal part 1
lh2=9; n% length of horizontal part 2
hsl=50; % height of sloped part
so=15;   % offset of sloped part top
hs=7;   % height of stopper
w=50;   % width
t=2.5;  % thickness
ta=t*sqrt(hsl^2+so^2)/hsl; % adjusted thickness for sloping angle
td=t*so/sqrt(hsl^2+so^2);  % thickness based offset to get right angle on top

x =[0  0 t+ta+lh1+lh2 t+ta+lh1+lh2 t+ta+lh2 t+ta+lh2+so t+lh2+so t+lh2 t t ]';
y =[hs 0 0            t            t        hsl+t-td    hsl+t    t     t hs]';
x2=[.1   .1 t+ta+lh1+lh2-.1 t+ta+lh1+lh2-.1 t+ta+lh2 t+ta+lh2-.1 t+lh2+.1 t+lh2 t    t-.1]';
y2=[t-.1 .1 .1              t-.1            t-.1     t-.1        t-.1     t-.1  t-.1 t-.1]';

slices={[x2,y2,0*x],[x,y,0*x],[x,y,w*ones(size(x))],[x2,y2,w*ones(size(x))]};

writeSlices(backwards(slices),'iPhoneHolder','iPhoneHolder.obj','cap');
