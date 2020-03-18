% Fletcher-Reeves Method or Conjugate Gradient Method:
% Written by Soumitra Sitole
% Date: Mar 5, 2017
clc
clear
format long
% Function Definition (Enter your Function here):
syms X Y;
f = X - Y + 2*X^2 + 2*X*Y + Y^2;
% Initial Guess:
x(1) = 1;
y(1) = -5;
e = 10^(-8); % Convergence Criteria
i = 1; % Iteration Counter
% Gradient Computation:
df_dx = diff(f, X);
df_dy = diff(f, Y);
J = [subs(df_dx,[X,Y], [x(1),y(1)]) subs(df_dy, [X,Y], [x(1),y(1)])]; % Gradient
S = -(J); % Search Direction
% Minimization Condition:
while norm(S) > e 
    I = [x(i),y(i)]';
    syms h; % Step size
    g = subs(f, [X,Y], [x(i)+S(1)*h,y(i)+h*S(2)]);
    dg_dh = diff(g,h);
    h = solve(dg_dh, h); % Optimal Step Length
    x(i+1) = I(1)+h*S(1); % New x value
    y(i+1) = I(2)+h*S(2); % New y value
    J_old = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])];
    i = i+1;
    J_new = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])]; % Updated Gradient
    S = -(J_new)+((norm(J_new))^2/(norm(J_old))^2)*S; % New Search Direction
end
% Result Table:`
Iter = 1:i;
X_coordinate = x';
Y_coordinate = y';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);
% Plots:
fcontour(f, 'Fill', 'On');
hold on;
plot(x,y,'*-r');
% Output:
fprintf('Initial Objective Function Value: %d\n\n',subs(f,[X,Y], [x(1),y(1)]));
if (norm(S) < e)
    fprintf('Minimum succesfully obtained...\n\n');
end
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x(i), y(i));
fprintf('Objective Function Minimum Value: %d\n\n', subs(f,[X,Y], [x(i),y(i)]));
disp(T)
