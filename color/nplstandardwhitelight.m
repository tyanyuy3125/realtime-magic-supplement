close all;

% 0.40:0.01:0.76 International Standard Visibility Curve (ICI 1924)
v_lambda = [0.0004 0.0012 0.0040 0.0116 0.023 0.038 0.060 0.091 0.139 0.208 0.323 0.503 0.710 0.862 0.954 0.995 0.995 0.952 0.870 0.757 0.631 0.503 0.381 0.265 0.175 0.107 0.061 0.032 0.017 0.0082 0.0041 0.0021 0.00105 0.00052 0.00025 0.00012 0.00006];
v_lambda_idx = 0.40:0.01:0.76;
figure;
scatter(v_lambda_idx, v_lambda, 'Marker', 'x');
hold on;
v_lambda_interpolated = interp1(v_lambda_idx, v_lambda, 0.40:0.001:0.76, 'spline');
plot(0.40:0.001:0.76, v_lambda_interpolated);
title('International Standard Visibility Curve (ICI 1924)');
hold off;

% 0.38:0.005:0.78 Energy Distribution Curve of NPL Standard White Light;
% values reduced so that E=100 at \lambda = 0.56\mu
e_lambda = [28.0 32.0 35.5 39.0 43.2 47.4 51.55 55.7 60.15 64.0 67.3 70.1 72.6 74.4 75.9 77.1 78.2 79.2 80.1 80.8 81.2 81.5 81.65 81.55 80.9 79.75 79.1 79.4 81.1 83.9 86.75 89.6 92.35 94.8 97.1 98.9 100.0 100.3 100.1 99.3 97.9 96.15 94.7 93.6 92.15 90.6 89.45 88.7 88.05 87.6 87.4 87.4 87.65 87.85 87.95 87.95 87.9 87.7 87.5 87.25 86.95 86.65 86.3 86.0 85.65 85.2 84.6 83.95 83.2 82.65 81.6 80.7 79.7 78.9 77.7 76.4 75.1 73.9 72.7 71.3 69.8];
e_lambda_idx = 0.38:0.005:0.78;
figure;
scatter(e_lambda_idx, e_lambda, 'Marker', 'x');
hold on;
e_lambda_interpolated = interp1(e_lambda_idx, e_lambda, 0.38:0.001:0.78, 'spline');
plot(0.38:0.001:0.78, e_lambda_interpolated);
title('Energy Distribution Curve of NPL Standard White Light');
hold off;

% V_lambda .* E_lambda
v_lambda_e_lambda = e_lambda(find(e_lambda_idx == 0.40):find(e_lambda_idx == 0.76)) .* interp1(0.40:0.01:0.76, v_lambda, 0.40:0.005:0.76, 'spline');
figure;
scatter(0.40:0.005:0.76, v_lambda_e_lambda, 'Marker', 'x');
hold on;
v_lambda_e_lambda_interpolated = interp1(0.40:0.005:0.76, v_lambda_e_lambda, 0.40:0.001:0.76, 'spline');
plot(0.40:0.001:0.76, v_lambda_e_lambda_interpolated);
title('V_\lambdaE_\lambda');
hold off;

standard_primaries = [0.700 0.5461 0.4358];
disp(interp1(0.40:0.005:0.76, v_lambda_e_lambda, standard_primaries, 'spline'));
disp(interp1(0.40:0.01:0.76, v_lambda, standard_primaries, 'spline'));