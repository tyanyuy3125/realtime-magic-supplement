% This is a modified version of César Delgado González's answer in '3D
% Antenna Plot' discussion on https://comp.soft-sys.matlab.narkive.com/zjdcLGlN/3d-antenna-plot

clear all
close all hidden

n_tehta = 64;
n_phi = 64;
[tehta,phi]=meshgrid(0:pi/2./(n_tehta-1):pi/2,...
0:2*pi./(n_phi-1):2*pi) ;

theta_i = deg2rad(45);
phi_i = deg2rad(0);
radio = 1/(pi);

X=radio.*sin(tehta).*cos(phi);
Y=radio.*sin(tehta).*sin(phi);
Z=radio.*cos(tehta);

mesh(X,Y,Z);
hold on;
quiver3([0 0],[0 0],[0 0],[sin(theta_i)*cos(phi_i)/2 0],[sin(theta_i)*sin(phi_i)/2 0],[cos(theta_i)/2 1/2],'Color','b');
text(sin(theta_i)*cos(phi_i)/2,sin(theta_i)*sin(phi_i)/2,cos(theta_i)/2,'Incident','FontSize',15,'Color','b');
text(0,0,1/2,'Normal','FontSize',15,'Color','b');
title('Lambertian BRDF');
axis image;