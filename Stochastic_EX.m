w1=0.5; %weight of the first objective
w2=0.5; %weight of the second objective
obj1=[3 , 5 ]; %first objective, Max
obj2=[2, -3 ]; %second objective, Min

LHS_C=[1 1 ; 1 0 ; 0 2 ]; %LHS of the constraints
RHS_C=[0;0;0]; %RHS of the constraints

%E_b is the expected value of each stochastic number in a constraint
%var_b is the variance of each stochastic number in a constraint
%p is the value that gets the value of e from the normal distribution table
E_b0=8; var_b0=25;  p0=0.7257;
E_b1=2; var_b1=4;   p1=0.5;
E_b2=7; var_b2=16;  p2=0.4013;


E0 = -norminv(p0); %get the absolute value of the normal distribution of p of the first stochastic number
E1 = -norminv(p1); %get the absolute value of the normal distribution of p of the second stochastic number
E2 = -norminv(p2); %get the absolute value of the normal distribution of p of the third stochastic number 

fprintf('The absolute value of the normal distribution of p of the 1st stochastic number is:')
E0
fprintf('The absolute value of the normal distribution of p of the 2nd stochastic number is:')
E1
fprintf('The absolute value of the normal distribution of p of the 3rd stochastic number is:')
E2


%multiply the objective functions by the weights and -1, since they are
%maximization, and add them together to have a single objective  
obj=-1*w1*obj1 + w2*obj2;

%calculate the new RHS of the constraints
RHS_C=[E_b0+(E0*sqrt(var_b0));E_b1+(E1*sqrt(var_b1));E_b2+(E2*sqrt(var_b2))];
RHS_C
%solve the new problem using linear programming function

lb=zeros(2,1);
[x,fval]=linprog(obj,LHS_C,RHS_C,[],[],lb);
fprintf('The optimal objective function value :')
z=-fval
fprintf('The optimal values of the decision variables')
x
