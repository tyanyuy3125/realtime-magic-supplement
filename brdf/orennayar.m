% This is a modified version of César Delgado González's answer in '3D
% Antenna Plot' discussion on https://comp.soft-sys.matlab.narkive.com/zjdcLGlN/3d-antenna-plot

clear all
close all hidden

n_theta = 128;
n_phi = 128;
[theta,phi]=meshgrid(0:pi/2./(n_theta-1):pi/2,...
0:2*pi./(n_phi-1):2*pi);

X=sin(theta).*cos(phi);
Y=sin(theta).*sin(phi);
Z=cos(theta);
size(X)
omega_o = [X;Y;Z];
size(omega_o)

Bas = 0.5;
k_a = 0.1;
k_d = 0.2;
k_s = 1.0;
radio = k_a + k_d * max(0, cos(theta_i)) %+ k_s * max(0, );

X=radio.*sin(theta).*cos(phi);
Y=radio.*sin(theta).*sin(phi);
Z=radio.*cos(theta);

mesh(X,Y,Z);
title('Oren-Nayar BRDF');
axis image;

