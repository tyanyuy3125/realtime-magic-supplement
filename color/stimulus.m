close all;

distrib = [0.00003 -0.00001 0.00117; % 380
           0.00005 -0.00002 0.00189;
           0.00010 -0.00004 0.00359;
           0.00017 -0.00007 0.00647;
           
           0.00030 -0.00014 0.01214; % 400
           0.00047 -0.00022 0.01969;
           0.00084 -0.00041 0.03707;
           0.00139 -0.00070 0.06637;
           0.00211 -0.00110 0.11541;
           
           0.00266 -0.00143 0.18575; % 425
           0.00218 -0.00119 0.24769;
           0.00036 -0.00021 0.29012;
           -0.00261 0.00149 0.31228;
           -0.00673 0.00379 0.31860;
           
           -0.01213 0.00678 0.31670; % 450
           -0.01874 0.01046 0.31166;
           -0.02608 0.01485 0.29821;
           -0.03324 0.01977 0.27295;
           -0.03933 0.02538 0.22991;
           
           -0.04471 0.03183 0.18592; % 475
           -0.04939 0.03914 0.14494;
           -0.05364 0.04713 0.10968;
           -0.05814 0.05689 0.08257;
           -0.06414 0.06948 0.06246;
           
           -0.07173 0.08536 0.04776; % 500
           -0.08120 0.10593 0.03688;
           -0.08901 0.12860 0.02698;
           -0.09356 0.15262 0.01842;
           -0.09264 0.17468 0.01221;
           
           -0.08473 0.19113 0.00830; % 525
           -0.07101 0.20317 0.00549;
           -0.05316 0.21083 0.00320;
           -0.03152 0.21466 0.00146;
           -0.00613 0.21487 0.00023;
           
           0.02279 0.21178 -0.00058; % 550
           0.05514 0.20588 -0.00105;
           0.09060 0.19702 -0.00130;
           0.12840 0.18522 -0.00138;
           0.16768 0.17087 -0.00135;
           
           0.20715 0.15429 -0.00123; % 575
           0.24526 0.13610 -0.00108;
           0.27989 0.11686 -0.00093;
           0.30928 0.09754 -0.00079;
           0.33184 0.07909 -0.00063;
           
           0.34429 0.06246 -0.00049; % 600
           0.34756 0.04776 -0.00038;
           0.33971 0.03557 -0.00030;
           0.32265 0.02583 -0.00022;
           0.29708 0.01828 -0.00015;
           
           0.26348 0.01253 -0.00011; % 625
           0.22677 0.00833 -0.00008;
           0.19233 0.00537 -0.00005;
           0.15968 0.00334 -0.00003;
           0.12905 0.00199 -0.00002;
           
           0.10167 0.00116 -0.00001; % 650
           0.07857 0.00066 -0.00001;
           0.05932 0.00037 0;
           0.04366 0.00021 0;
           0.03149 0.00011 0;
           
           0.02294 0.00006 0; % 675
           0.01687 0.00003 0;
           0.01187 0.00001 0;
           0.00819 0 0;
           0.00572 0 0;
           
           0.00410 0 0; % 700
           0.00291 0 0;
           0.00210 0 0;
           0.00148 0 0;
           0.00105 0 0;
           
           0.00074 0 0; % 725
           0.00052 0 0;
           0.00036 0 0;
           0.00025 0 0;
           0.00017 0 0;
           
           0.00012 0 0; % 750
           0.00008 0 0;
           0.00006 0 0;
           0.00004 0 0;
           0.00003 0 0;
           0.00001 0 0; % 775
           0.00001 0 0;];

disp("Integral per stimulus:");
disp(sum(distrib(:,1)));
disp(sum(distrib(:,2)));
disp(sum(distrib(:,3)));

unitized_distrib = distrib;
for i = 1:80
    unitized_distrib(i,:) = unitized_distrib(i,:) / sum(unitized_distrib(i,:));
end

disp("Trichromatic coefficients:");
disp(unitized_distrib);

figure;
plot(0.380:0.005:0.780, unitized_distrib);
legend('R', 'G', 'B');
title('Trichromatic Coefficients (CIE 1931 RGB)');

figure;
plot(0.380:0.005:0.780, distrib);
legend('r', 'g', 'b');
title('Distribution coefficients for equal energy stimulus (CIE 1931 RGB)');

% Above RGB
% Below XYZ

matRGBtoXYZ = transpose([0.4900 0.3100 0.2000;0.17697 0.8124 0.01063;0.0000 0.01 0.99]);

unitized_xyz = unitized_distrib * matRGBtoXYZ;
xyz = distrib * matRGBtoXYZ;

disp("Integral of XYZ:");
disp(sum(xyz(:,1)));
disp(sum(xyz(:,2)));
disp(sum(xyz(:,3)));

figure;
plot(0.380:0.005:0.780, unitized_xyz);
legend('X', 'Y', 'Z');
title('Trichromatic coefficients (CIE 1931 XYZ)');

figure;
plot(0.380:0.005:0.780, xyz);
legend('x', 'y', 'z');
title('Distribution coefficients for equal energy stimulus (CIE 1931 XYZ)');

% Unitized to Distrib with ICI 1924 Luminosity Curve
v_lambda = [0.0000 0.0002 0.0004 0.0012 0.0040 0.0116 0.023 0.038 0.060 0.091 0.139 0.208 0.323 0.503 0.710 0.862 0.954 0.995 0.995 0.952 0.870 0.757 0.631 0.503 0.381 0.265 0.175 0.107 0.061 0.032 0.017 0.0082 0.0041 0.0021 0.00105 0.00052 0.00025 0.00012 0.00006 0.0002 0.0000];
v_lambda_idx = 0.38:0.01:0.78;
v_lambda_interpolated = interp1(v_lambda_idx, v_lambda, 0.38:0.005:0.78, 'spline');
figure;
plot(0.38:0.005:0.78, v_lambda_interpolated);
title('ICI 1924 Luminosity Curve');

v_lambda_db = 10*log10(max(0,v_lambda_interpolated));
figure;
plot(0.38:0.005:0.78, v_lambda_db);
title('ICI 1924 Luminosity Curve (Logarithmic)');

e_lambda = [28.0 32.0 35.5 39.0 43.2 47.4 51.55 55.7 60.15 64.0 67.3 70.1 72.6 74.4 75.9 77.1 78.2 79.2 80.1 80.8 81.2 81.5 81.65 81.55 80.9 79.75 79.1 79.4 81.1 83.9 86.75 89.6 92.35 94.8 97.1 98.9 100.0 100.3 100.1 99.3 97.9 96.15 94.7 93.6 92.15 90.6 89.45 88.7 88.05 87.6 87.4 87.4 87.65 87.85 87.95 87.95 87.9 87.7 87.5 87.25 86.95 86.65 86.3 86.0 85.65 85.2 84.6 83.95 83.2 82.65 81.6 80.7 79.7 78.9 77.7 76.4 75.1 73.9 72.7 71.3 69.8];
v_lambda_e_lambda = v_lambda_interpolated .* e_lambda;
figure;
plot(0.38:0.005:0.78, v_lambda_e_lambda);
title('Luminosity Curve of NPL Standard White Light via ICI 1924 Luminosity Curve');

disp('Luminosity intergal (10nm interval):');
disp(sum(v_lambda)); % 10.6860

disp('Luminosity integral (5nm interval):');
disp(sum(v_lambda_interpolated)); % 21.3721。这个结果非常熟悉，它出现在 J.Guild 1931 的标准论文表 III 的 Totals 栏。

luminosity_factor = [1 4.5907 0.0601];

distrib_derived = unitized_distrib;

for i = 1:length(0.38:0.005:0.78)
    luminosity_val = distrib_derived(i,:) * transpose(luminosity_factor);
    distrib_derived(i,:) = distrib_derived(i,:) * v_lambda_interpolated(i) * 100 * 0.01 / luminosity_val; % 采用 NPL 标准白光的效果反而不好。
%     disp(v_lambda_interpolated(i) * 0.005 / luminosity_val);
end

figure;
plot(0.38:0.005:0.78, distrib_derived);
legend('R', 'G', 'B');
title('Distribution coefficients for equal energy stimulus (CIE 1931 RGB) derived from trichromatic coefficients');

disp("Integral per stimulus (derived from trichromatic coefficients):");
disp(sum(distrib_derived(:,1)));
disp(sum(distrib_derived(:,2)));
disp(sum(distrib_derived(:,3)));

% 考虑等能量各个分量的求和。
distrib_sum = zeros(length(0.38:0.005:0.78), 1);
for i = 1:length(0.38:0.005:0.78)
    distrib_sum(i) = sum(distrib_derived(i,:));
end

plot(0.38:0.005:0.78, distrib_sum);