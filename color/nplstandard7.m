close all;

global lambda;
lambda = 0.38:0.005:0.70;

global cmf_w;
cmf_w = [0.0683 -0.0819 1.0136;
         0.0683 -0.0819 1.0136;
         0.0683 -0.0819 1.0136;
         0.0683 -0.0819 1.0136;
         0.0683 -0.0819 1.0136;
         0.0670 -0.0808 1.0138;
         0.0655 -0.0795 1.0140;
         0.0638 -0.0780 1.0142
         0.0613 -0.0754 1.0141;
         0.0590 -0.0725 1.0135;
         0.0554 -0.0688 1.0134;
         0.0502 -0.0646 1.0144;
         0.0443 -0.0596 1.0153;
         0.0365 -0.0528 1.0163;
         0.0262 -0.0448 1.0186;
         0.0130 -0.0327 1.0197;
         -0.0030 -0.0175 1.0205;
         -0.0255 0.0056 1.0199;
         -0.0554 0.0420 1.0134;
         -0.0980 0.1010 0.9970;
         -0.1531 0.1843 0.9688;
         -0.2290 0.3125 0.9165;
         -0.3178 0.4839 0.8339;
         -0.4120 0.6964 0.7156;
         -0.5010 0.9247 0.5763;
         -0.5550 1.1290 0.4260;
         -0.5660 1.2870 0.2790;
         -0.5250 1.3670 0.1580;
         -0.4440 1.3620 0.0820;
         -0.3430 1.3020 0.0410;
         -0.2390 1.2230 0.0160;
         -0.1417 1.1410 0.0007;
         -0.0500 1.0590 -0.0090;
         0.0404 0.9740 -0.0144;
         0.1279 0.8890 -0.0169;
         0.2143 0.8030 -0.0173;
         0.2977 0.7190 -0.0167;
         0.3796 0.6360 -0.0156;
         0.4600 0.5540 -0.0140;
         0.5380 0.4740 -0.0120;
         0.6120 0.3980 -0.0100;
         0.6815 0.3270 -0.0085;
         0.7427 0.2640 -0.0067;
         0.7980 0.2070 -0.0050;
         0.8465 0.1570 -0.0035;
         0.8876 0.1150 -0.0026;
         0.9238 0.0780 -0.0018
         0.9523 0.0490 -0.0013;
         0.9748 0.0260 -0.0008;
         0.9925 0.0078 -0.0003;
         1.0068 -0.0068 0.0000;
         1.0188 -0.0188 0.0000;
         1.0290 -0.0290 0.0000;
         1.0370 -0.0370 0.0000;
         1.0430 -0.0430 0.0000;
         1.0480 -0.0480 0.0000;
         1.0509 -0.0509 0.0000;
         1.0532 -0.0532 0.0000;
         1.0550 -0.0550 0.0000;
         1.0565 -0.0565 0.0000;
         1.0580 -0.0580 0.0000;
         1.0590 -0.0590 0.0000;
         1.0599 -0.0599 0.0000;
         1.0603 -0.0603 0.0000;
         1.0604 -0.0604 0.0000;
         ];
global cmf_std;
cmf_std = zeros(size(cmf_w));

workingPrimariesVerification();

figure;
plot(lambda, cmf_w);
legend('R_w','G_w','B_w');
title('CMF of Working Primaries');

drawLocus(cmf_w, 1, 'Locus of Working Primaries');
drawLocus3(cmf_w, '3D locus of working primaries');

standardPrimariesRep = getColorAtWavelengthWithWorkingPrimaries([0.700;0.5461;0.4358]);
workingToStandardTrans = getPrimariesTransformationMatrix(standardPrimariesRep);

disp(workingToStandardTrans);

global luminous_wp;
global luminous_std;
luminous_wp = [1 2.858 0.169];
S = sum(luminous_wp);

T= [1.0604 -0.0604 0;0.0600 0.9552 -0.0152;0.0492 -0.0638 1.0146];

luminous_std = (1/S)*inv(T)*transpose(luminous_wp);
luminous_std = luminous_std / luminous_std(1);
luminous_std = transpose(luminous_std);
disp(['Luminous factor of standard primaries: ']);
disp(luminous_std);

cmf_w_luminous = cmf_w * transpose(luminous_wp);
% cmf_w_luminous = cmf_w_luminous / max(cmf_w_luminous);
disp(cmf_w_luminous);

figure;
plot(lambda, cmf_w_luminous);
legend('L_w');
title('Luminous of Working Primaries');

cmf_std = cmf_w * workingToStandardTrans;
cmf_std_normalized = SumNormalize(cmf_std);

figure;
plot(lambda, cmf_std_normalized);
legend('R','G','B');
title('CMF of Standard Primaries (Sum Normalized)');

drawLocus(cmf_std_normalized, 1, 'Locus of Standard Primaries (Sum Normalized)');
drawLocus3(cmf_std_normalized, '3D locus plot of standard primaries (sum normalized)');

cmf_std_luminous = cmf_std_normalized * transpose(luminous_std);
% cmf_std_luminous = cmf_std_luminous / max(cmf_std_luminous);
disp(cmf_std_luminous);

figure;
plot(lambda, cmf_std_luminous);
legend('L');
title('Luminous of Standard Primaries');

% 下面开始证明：无法使用单色光基底表示光谱上的所有颜色。
cmf_std_normalized_interpolated = interp1(lambda, cmf_std_normalized, 0.38:0.001:0.70, 'spline');
cmf_std_length_normalized = normalize(cmf_std_normalized_interpolated, 2);
% figure;
% plot(0.38:0.001:(0.70-0.001), cmf_std_length_normalized);

figure;
plot(0.38:0.001:(0.70-0.001), diff(cmf_std_length_normalized) / 0.001);
title('Derivative plot of x_e(\lambda), y_e(\lambda), z_e(\lambda)');

% 下面把 cmf_std 转换为 cmf_xyz
triangle = eye(3) * transpose([0.4900 0.3100 0.2000;0.17697 0.8124 0.01063;0.0000 0.01 0.99]);
tx = triangle(:, 1);
ty = triangle(:, 2);
tz = triangle(:, 3);
tyy = ty ./ (tx+ty+tz);
tzz = tz ./ (tx+ty+tz);
cmf_xyz = cmf_std * transpose([0.4900 0.3100 0.2000;0.17697 0.8124 0.01063;0.0000 0.01 0.99]); % 一些文献中的表达方法可能和这里有所区别。请注意，在这里我们始终认为变换方程中的RGB和XYZ等是基底而不是颜色数值。
cmf_xyz_normalized = SumNormalize(cmf_xyz);
figure;
plot(lambda, cmf_xyz_normalized);
legend('X', 'Y', 'Z');
title('CMF of XYZ');

drawLocus(cmf_xyz_normalized, 1, 'Locus of XYZ');
hold on;
plot([0 1],[1, 0], 'Color', [0.5 0.5 0.5]);
scatter(tzz, tyy, 'Marker', 'x'); 
hold off;
drawLocus3(cmf_xyz_normalized, '3D Locus of XYZ');
hold on;
scatter3(tx, ty, tz, 'Marker', 'x');
hold off;

function ret = SumNormalize(cmf)
    [row, ~] = size(cmf);
    for i = 1:row
        ret(i,:) = cmf(i,:) / sum(cmf(i,:));
    end
end

function drawLocus3(cmf, title_text )
    x = cmf(:,1);
    y = cmf(:,2);
    z = cmf(:,3);
    global lambda;

    figure;
    scatter3(x, y, z);

    xlabel('R');
    ylabel('G');
    zlabel('B');

    hold on;

    for i = 1:length(lambda)
        text(x(i), y(i), z(i), [num2str(lambda(i)) '\mu']);
    end

    lambda_ext = linspace(min(lambda), max(lambda), 250);
    xx = spline(lambda, x, lambda_ext);
    zz = spline(lambda, z, lambda_ext);
    yy = spline(lambda, y, lambda_ext);

    plot3(xx, yy, zz);
    title(title_text);
    quiver3(zeros(3,1),zeros(3,1),zeros(3,1),[2;0;0],[0;2;0],[0;0;2],'Color','b');

    text(1.5,0,0,'R','FontSize',15,'Color','b');
    text(0,1.5,0,'G','FontSize',15,'Color','b');
    text(0,0,1.5,'B','FontSize',15,'Color','b');

    hold off;
end

function drawLocus(cmf, sum, title_text)
    x = cmf(:,1);
    y = cmf(:,2);
    z = cmf(:,3);
    x = x / sum;
    y = y / sum;
    z = z / sum;
    global lambda;

    z = x;

    figure;
    scatter(z, y, 'Marker', 'x');
    xlabel('B');
    ylabel('G');
    hold on;

    for i = 1:length(lambda)
        text(z(i), y(i), [num2str(lambda(i)) '\mu']);
    end

    lambda_ext = linspace(min(lambda), max(lambda), 250);
    zz = spline(lambda, z, lambda_ext);
    yy = spline(lambda, y, lambda_ext);

    plot(zz, yy);
    title(title_text);

    hold off;
end

function ret = getPrimariesTransformationMatrix(A)
    l = A(1,1);
    l_ = A(1,2);
    l__ = A(1,3);
    m = A(2,1);
    m_ = A(2,2);
    m__ = A(2,3);
    n = A(3,1);
    n_ = A(3,2);
    n__ = A(3,3);
    
    p = m_*n__ - n_*m__;
    p_ = l_*n__- n_*l__;
    p__ = l_ * m__ - m_ * l__;
    q = m * n__ - n * m__;
    q_ = l * n__ - n * l__;
    q__ = l * m__ - m * l__;
    r = m * n_ - n * m_;
    r_ = l * n_ - n * l_;
    r__ = l * m_ - m * l_;
    
    ret = [p/(p-q+r) p_/(p_-q_+r_) p__/(p__-q__+r__); -q/(p-q+r) -q_/(p_-q_+r_) -q__/(p__-q__+r__);r/(p-q+r) r_/(p_-q_+r_) r__/(p__-q__+r__)];
end

function ret = getColorAtWavelengthWithWorkingPrimaries(wavelength)
    global cmf_w;
    global lambda;
    ret = interp1(lambda, cmf_w, wavelength, 'spline');
end

function workingPrimariesVerification()
    global cmf_w;
    [row_c, ~] = size(cmf_w);
    for index = 1:row_c
        if abs(norm(cmf_w(index, :), 1) - 1) < eps
            disp(['Verfication failed at ' num2str(index) ': ' num2str(sum(cmf_w(index, :)))]);
            break
        end
    end
    disp('Verification completed');
end