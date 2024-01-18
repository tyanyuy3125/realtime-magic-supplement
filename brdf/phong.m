% This is a modified version of César Delgado González's answer in '3D
% Antenna Plot' discussion on https://comp.soft-sys.matlab.narkive.com/zjdcLGlN/3d-antenna-plot

clear all
close all hidden

n_theta = 128;
n_phi = 128;
[theta,phi]=meshgrid(0:pi/2./(n_theta-1):pi/2,...
0:2*pi./(n_phi-1):2*pi) ;

Bas = 0.5;
sigma = 0.5;
theta_i = deg2rad(60);
phi_i = deg2rad(0);
A = 1-(sigma^2)/(2*(sigma^2+0.33));
B = (0.45*sigma^2)/(sigma^2+0.09);
alpha = max(theta_i, theta);
beta = min(theta_i, theta);
radio = (1/pi).*(A+B.*max(0, cos(phi_i-phi)).*sin(alpha).*tan(beta));

X=radio.*sin(theta).*cos(phi);
Y=radio.*sin(theta).*sin(phi);
Z=radio.*cos(theta);

mesh(X,Y,Z);
title('Oren-Nayar BRDF');
axis image;

