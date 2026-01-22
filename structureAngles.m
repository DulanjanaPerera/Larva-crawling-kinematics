function [cosalpha1, cosalpha2, alpha1, alpha2] = structureAngles(l)

cosalpha1 = (l(2) ^ 2 + l(3) ^ 2 - l(5) ^ 2) / l(2) / l(3) / 0.2e1;
cosalpha2 = (l(1) ^ 2 + l(4) ^ 2 - l(5) ^ 2) / l(1) / l(4) / 0.2e1;

alpha1 = acos((l(2) ^ 2 + l(3) ^ 2 - l(5) ^ 2) / l(2) / l(3) / 0.2e1);
alpha2 = acos((l(1) ^ 2 + l(4) ^ 2 - l(5) ^ 2) / l(1) / l(4) / 0.2e1);

end