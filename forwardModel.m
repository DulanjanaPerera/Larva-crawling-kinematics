function [T1,T2] = forwardModel(l)
% This function computes the position of the protopodium when lengths of
% each springs (muscles) and the angle is given
% 
% Inputs:
%   l   : vector containing lengths and the VL angle [6x1]
%
% Outputs:
%   T1  : position (f_p) of the bottom triangle protopodium [3x1] ([x,y,0])
%   T2  : position (f_p) of the bottom triangle protopodium [3x1] ([x,y,0])

T1 = [(-cos(l(6)) * (l(1) ^ 2 + l(4) ^ 2 - l(5) ^ 2) / l(1) / l(4) / 0.2e1 + sin(l(6)) * sqrt(0.4e1 - (l(1) ^ 2 + l(4) ^ 2 - l(5) ^ 2) ^ 2 / l(1) ^ 2 / l(4) ^ 2) / 0.2e1) * l(4) + cos(l(6)) * l(1) (-sin(l(6)) * (l(1) ^ 2 + l(4) ^ 2 - l(5) ^ 2) / l(1) / l(4) / 0.2e1 - cos(l(6)) * sqrt(0.4e1 - (l(1) ^ 2 + l(4) ^ 2 - l(5) ^ 2) ^ 2 / l(1) ^ 2 / l(4) ^ 2) / 0.2e1) * l(4) + sin(l(6)) * l(1) 0];
T2 = [sqrt((4 - (l(2) ^ 2 + l(3) ^ 2 - l(5) ^ 2) ^ 2 / l(2) ^ 2 / l(3) ^ 2)) * l(3) / 0.2e1 ((l(2) ^ 2 + l(3) ^ 2 - l(5) ^ 2) / l(2)) / 0.2e1 - l(2) 0];

end