
function [xKnt, outKnt,xCenter,xDelta] = myHistc(x, Nbins, Xend);
%function [xKnt, outKnt,xCenter,xDelta] = myHistc(x, Nbins, Xend);

% a histogram with Nbins within the range [Xend(1), Xend(2)]
% Xend (1:2), for edges, beyond Xend, data is counted in outKnt

FLAGprint = 1;%Change to 1 for printing and plotting

x = x(:);Lx = length(x);
outKnt = zeros(2,1);xKnt = zeros(Nbins,1);
Lindx=0;indx=find(x <= Xend(1));Lindx=length(indx);if(Lindx ~= 0);outKnt(1)=Lindx;end
x(indx)=[];
Lindx=0;indx=find(x  > Xend(2));Lindx=length(indx);if(Lindx ~= 0);outKnt(2)=Lindx;end
x(indx)=[];
xDelta = (Xend(2)-Xend(1))/Nbins;Xbin = Xend(1) + [0:Nbins]*xDelta;
xCenter = zeros(Nbins,1);

% Loop over the few bins, not over the many data
for ibin=[1:Nbins];% loop over bins, not data
    Lindx=0;indx=find(  (Xbin(ibin)< x)&( x <=Xbin(ibin+1)) );Lindx=length(indx);
     xCenter(ibin) = mean([Xbin(ibin) Xbin(ibin+1)]);
    if(Lindx~=0);xKnt(ibin)=Lindx;end%%x(indx)=[];end
    disp([ibin, Xbin(ibin) Xbin(ibin+1) xCenter(ibin) xKnt(ibin)]) 
end

if(FLAGprint==1);
format bank
disp(['          BinID      LowEdge        UpEdge        Center         Count'])
for ibin=[1:Nbins];% loop over bins, not data
    disp([ibin, Xbin(ibin) Xbin(ibin+1) xCenter(ibin) xKnt(ibin)]) 
end
end


format short e
if(FLAGprint==1);
% plot( xCenter,xKnt,'r*-');grid
end

