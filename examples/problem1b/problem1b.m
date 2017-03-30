clear; close all; clc;

% global variables :
global x10 x20

% initial conditions:
x10 = 1;
x20 = 0;

% Optimization : 
options = sdpoptionset('LargeScale','on','Display','iter','TolFun',1e-7,...
                       'TolCon',1e-7,'TolX',1e-7,...
                       'MaxFunEvals',1e6,'MaxIter',4000,...
                       'Algorithm','sqp','NLPsolver','fmincon',...
                       'DerivativeCheck','on','GradObj','on',...
                       'GradConstr','on');

optimparam.optvar = 3;
optimparam.objtype = [];
optimparam.ncolx = 6; 
optimparam.ncolu = 2; 
optimparam.li = ones(4,1)*(1/4);
optimparam.tf = 1;
optimparam.ui = zeros(1,4);
optimparam.par = []; 
optimparam.bdu = []; 
optimparam.bdx = [0 1;0 1]; 
optimparam.bdp = [];
optimparam.objfun  = @objfun_function;
optimparam.confun  = @confun_function;
optimparam.process = @process_function;
optimparam.options = options;

[optimout,optimparam] = dynopt(optimparam);
[tplot,uplot,xplot]   = profiles(optimout,optimparam,50);

figure
subplot(2,1,1)
plot(tplot, xplot)
xlabel('t')
ylabel('x')

subplot(2,1,2)
plot(tplot, uplot)
xlabel('t')
ylabel('u')