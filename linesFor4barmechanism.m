function out = linesFor4barmechanism(l)

[cosalpha1, cosalpha2, alpha1, alpha2] = structureAngles(l);
alpha = [alpha1, alpha2];

% structure of the matrix -- [x1 x2; y1 y2]

l1 = [0, l(1); 0, 0];
l2 = [0, 0; 0, -l(2)];
l3 = [0, l(3) * sin(pi-alpha(1)); -l(2), -l(2) - l(3) * cos(pi-alpha(1))];
l4 = [l(1), l(3) * sin(pi-alpha(1)); 0, -l(2) - l(3) * cos(pi-alpha(1))];

out = [];
out(:,:,1) = l1;
out(:,:,2) = l2;
out(:,:,3) = l3;
out(:,:,4) = l4;


end