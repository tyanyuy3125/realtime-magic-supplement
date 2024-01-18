% This is a modified version of César Delgado González's answer in '3D
% Antenna Plot' discussion on https://comp.soft-sys.matlab.narkive.com/zjdcLGlN/3d-antenna-plot

clear all
close all hidden

n_tehta = 64;
n_phi = 64;
[tehta,phi]=meshgrid(0:pi/2./(n_tehta-1):pi/2,...
0:2*pi./(n_phi-1):2*pi) ;

Bas = 0.5;
radio = 1/(pi);

X=radio.*sin(tehta).*cos(phi);
Y=radio.*sin(tehta).*sin(phi);
Z=radio.*cos(tehta);

mesh(X,Y,Z);
title('Lambertian BRDF');
axis image;