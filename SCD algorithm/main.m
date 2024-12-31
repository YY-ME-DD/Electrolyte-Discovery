
%% Data loading

Data_ela= xlsread('Ternay_design_space.xlsx');

%% Initialization

popsize=50;                                                                   % Stem-cell population

chromlength=19;                                                               % length of gene fragment

pm=0.1;                                                                       % Probability of transformation

%% Optimization

pop=initpop(popsize,chromlength);                                             % Cell population

for i=1:50                                                                    % Number of differentiation

    [objvalue]=calobjvalue(popsize,pop,Data_ela,net,tr_input,tr_output);      % Objective function

    fitvalue=calfitvalue(objvalue);                                           % Adaptation

    [newpop]=division(pop,fitvalue);                                          % Cell division

    [newpop1]=differentiation(newpop,fitvalue);                               % Cell differentiation

    [newpop2]=conversion(newpop1,pm);                                         % Cell transformation

    [objvalue]=calobjvalue(popsize,newpop2,Data_ela,net,tr_input,tr_output);  % Objective function

    fitvalue=calfitvalue(objvalue);                                           % Adaptation

    [bestindividual,bestfit]=best(newpop2,fitvalue);                          % Optimal adaptation and gene fragment

    y(i)=bestfit;                                                             % Value of optimal adaptation in this differentiation

    x(:,i)=bestindividual';                                                   % Value of optimal gene fragment in this differentiation

    pop=newpop2;

end

%% Electrolytes

[z ,index]=min(y);                                                            % parameters of optimal electrolyte

xmin=x(:,index)';                                                             % Value of optimal gene fragment

ymin=z;                                                                       % Value of optimal adaptation

group_1=xmin(:,1:2);                                                          % Number of first group (binary)

ratio_1=xmin(:,3:6);                                                          % Ratio of first group (binary)

group_2=xmin(:,7:10);                                                         % Number of seconed group (binary)

ratio_2=xmin(:,11:14);                                                        % Ratio of seconed group (binary)

group_3=xmin(:,15:19);                                                        % Number of third group (binary)

Group_1=decodechrom(group_1,1,2);                                             % Number of first group (decimalism)

if Group_1==0
    Group_1=1;
    i=i+1;
else
    i=i+1;
end

Ratio_1=decodechrom(ratio_1,1,4)/10;                                          % Ratio of first group (decimalism)

if Ratio_1== 0
    Ratio_1=0.1;
    i=i+1;
else
    i=i+1;
end

Group_2=decodechrom(group_2,1,4);                                             % Number of seconed group (decimalism)

if Group_2> 12 || Group_2== 0
    Group_2=1;
    i=i+1;
else
    i=i+1;
end

Ratio_2=decodechrom(ratio_2,1,4)/10;                                          % Ratio of seconed group (decimalism)

if Ratio_2== 0
    Ratio_2=0.1;
    i=i+1;
else
    i=i+1;
end

Group_3=decodechrom(group_3,1,5);                                             % Number of third group (decimalism)

if Group_3> 23 || Group_3== 0
    Group_3=1;
    i=i+1;
else
    i=i+1;
end

Ratio_3=1-Ratio_1-Ratio_2;                                                    % Ratio of third group (decimalism)

if Ratio_3< 0
    Ratio_1=0.1;
    Ratio_2=0.1;
    Ratio_3=0.8;
    i=i+1;
else
    i=i+1;
end

A=[Group_1, Group_2, Group_3];                                                

B=[Ratio_1, Ratio_2, Ratio_3];

disp(['Formula of electrolyte：', num2str(A)])

disp(['Ratio of electrolyte：', num2str(B)])

disp(['Metric of electrolyte：', num2str(ymin*ymin)])




