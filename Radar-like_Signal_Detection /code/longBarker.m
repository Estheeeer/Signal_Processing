function [longCode] = longBarker(C,Barker)
% function [longCode] = longBarker(leng,Barker)
clength = length(C);
Blength = length(Barker);
longCode = zeros(1,clength*Blength);
cnt = 1;

for j = 1:Blength
   for k = 1:clength
       longCode(cnt) = Barker(j)*C(k);
       cnt = cnt+1;
   end
end
end

