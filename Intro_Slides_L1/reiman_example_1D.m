% Riemann sum approximation for a concave function with max near x = 0.8
clear; close all; clc;

% Define a smooth, concave function with maximum near 0.8
f = @(x) 1.5 * (x.^0.5) .* (1 - 0.8*x);  % concave on [0,1], peak ~0.8

% Domain and grid
n = 10;                     % number of rectangles
x = linspace(0, 1, 200);    % dense grid for smooth curve
dx = 1/n;
x_mid = (0.5:1:n-0.5)/n;    % midpoints
y = f(x);
y_mid = f(x_mid);

% Compute Riemann sum approximation
I_hat = mean(y_mid);
fprintf('Riemann-sum approximation: %.4f\n', I_hat);

% Plot
figure('Color','w','Position',[200 200 700 400]);
hold on;

% Plot Riemann rectangles
for i = 1:n
    x0 = (i-1)/n; 
    rectangle('Position',[x0,0,dx,y_mid(i)],...
              'FaceColor',[0.2 0.2 0.2],'EdgeColor','none');
end

% Plot f(x)
plot(x, y, 'r', 'LineWidth', 2);
plot(x_mid, y_mid, 'ko', 'MarkerFaceColor','k');

% Labels and styling
xlabel('x','FontSize',12);
ylabel('y','FontSize',12);
title('Riemann Sum Approximation','FontSize',14);
grid on; box on;
xlim([0 1]); ylim([0 max(y)*1.2]);

% Caption
text(0.05, max(y)*1.15, ...
    '{\bf Figure:} Riemann sum approximation (black rectangles) of the integral of f (red curve).', ...
    'FontSize',9,'Interpreter','tex');

hold off