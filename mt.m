clc
clear
startup_rvc


l(1) = Link('prismatic', 'theta', 0, 'a', 0, 'alpha', pi/2,'modified');
l(2) = Link('revolute', 'd', 0, 'a', 0, 'alpha', pi/2,'modified');
l(3) = Link('prismatic', 'theta', pi/2, 'a', 0, 'alpha', 0,'offset',1085,'modified');
l(4) = Link('revolute', 'd', 0, 'a', 450, 'alpha', 0,'modified');
l(5) = Link('revolute', 'd', 0, 'a', 0, 'alpha', pi/4,'modified');
l(6) = Link([0,0,0,-pi/4],'modified');
R = SerialLink(l,'name', '5 DOF');

samples = 500;
time = linspace(0,12, samples);
x = 350*sin(10*pi/3*time);
y = -100*time - 400;
z = -(x.^2/150 - (y+1000).^2/200)/4 - 2000;

T = [x' y' z'];
q = zeros(samples,6);
for index = 1:samples
   Px = T(index,1);
   Py = T(index,2);
   Pz = T(index,3);
   [q1,q2,q3,q4,q5,q6] = inverse_kine(Px,Py,Pz);
   q(index,:) = [q1,q2,q3,q4,q5,q6];
end


figure;
title("3D animation")
R.plot(q,'workspace', [-2000 2000 -3000 200 -4000 0]);

function [q1,q2,q3,q4,q5,q6] = inverse_kine(X,Y,Z)
    q2 = -asin(X/450);
    q1 = -Y - 450*cos(q2);
    q3 = - 465 - 50 - 2*285 - Z;
    q4 = -q2;
    q5 = 0;
    q6 = 0;
end
