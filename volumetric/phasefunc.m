close all

theta = 0:0.01:2*pi;
rho = (3/8)*(1+cos(theta).*cos(theta));
figure
polarplot(theta,rho)
title('Rayleigh Phase Function')

figure
g=0.2;
rho = (1/4*pi)*(1-g^2)./(1+g^2+2*g*cos(theta)).^(3/2);
polarplot(theta,rho)
hold on
g=0.4;
rho = (1/4*pi)*(1-g^2)./(1+g^2+2*g*cos(theta)).^(3/2);
polarplot(theta,rho)
hold on
g=0.6;
rho = (1/4*pi)*(1-g^2)./(1+g^2+2*g*cos(theta)).^(3/2);
polarplot(theta,rho)
hold on
g=-0.6;
rho = (1/4*pi)*(1-g^2)./(1+g^2+2*g*cos(theta)).^(3/2);
polarplot(theta,rho)
hold off
legend('g=0.2','g=0.4','g=0.6','g=-0.6')
title('Henyey–Greenstein Phase Function')

theta = 0:0.01:2*pi;
rho = ones(size(theta))*(1/(4*pi));
figure
polarplot(theta,rho)
rlim([-2/(4*pi) 2/(4*pi)])
title('Homogeneous Phase Function')