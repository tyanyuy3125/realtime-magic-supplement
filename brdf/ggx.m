% This is a modified version of César Delgado González's answer in '3D
% Antenna Plot' discussion on https://comp.soft-sys.matlab.narkive.com/zjdcLGlN/3d-antenna-plot

clear all
close all hidden

n_theta = 128;
n_phi = 128;
[theta,phi]=meshgrid(0:pi/2./(n_theta-1):pi/2,...
0:2*pi./(n_phi-1):2*pi) ;

theta_i = deg2rad(45);
phi_i = deg2rad(0);

X=sin(theta).*cos(phi);
Y=sin(theta).*sin(phi);
Z=cos(theta);

X_i = sin(theta_i)*cos(phi_i);
Y_i = sin(theta_i)*sin(phi_i);
Z_i = cos(theta_i);

X_h = X + X_i;
Y_h = Y + Y_i;
Z_h = Z + Z_i;

NORM_h = sqrt(X_h.^2 + Y_h.^2 + Z_h.^2);
X_h = X_h ./ NORM_h;
Y_h = Y_h ./ NORM_h;
Z_h = Z_h ./ NORM_h;

roughness = 0.2;
alpha = roughness^2;
D = (1/pi)*(1/(alpha^2))*(1./(Z_h.^2+(X_h.^2/alpha^2)+(Y_h.^2/alpha^2)).^2); % Burley
Lambda_i = (1/2)*(sqrt(alpha^2*(tan(theta_i))^2+1)-1);
Lambda_o = (1/2)*(sqrt(alpha^2*(tan(theta)).^2+1)-1);
G = (heaviside(X_i.*X_h+Y_i.*Y_h+Z_i.*Z_h).*heaviside(X.*X_h+Y.*Y_h+Z.*Z_h))./(Lambda_i + Lambda_o + 1); % GGX-Smith
n = 1.333;
f_0 = ((1 - n)/(1 + n))^2;
F = f_0 - (1 - f_0)*(1-cos(theta_i))^5;
radio = (D.*G)./(4*Z*Z_i);

X=radio.*sin(theta).*cos(phi);
Y=radio.*sin(theta).*sin(phi);
Z=radio.*cos(theta);

mesh(X,Y,Z);
hold on;
quiver3([0 0],[0 0],[0 0],[sin(theta_i)*cos(phi_i) 0],[sin(theta_i)*sin(phi_i) 0],[cos(theta_i) 1],'Color','b');
text(sin(theta_i)*cos(phi_i),sin(theta_i)*sin(phi_i),cos(theta_i),'Incident','FontSize',15,'Color','b');
text(0,0,1,'Normal','FontSize',15,'Color','b');
title('GGX BRDF (Burley D distribution, GGX-Smith G distribution)');
axis image;

