%% Initialization

clc; clear; close all

%%  Data loading

data = xlsread('Data_electrolytes.xlsx');

data(:, 29) = sqrt(data(:, 29));

%%  Dataset setting

TE = randperm(100); % Random sort

Fea = [1 3 5 8 11]; % Frature setting

Tr_in = data(TE(1: 80), Fea )';% input_train

Tr_out = data(TE(1: 80), 29)';% output_train

Te_in = data(TE(81: 100), Fea)';% input_test

Te_out = data(TE(81: 100), 29)';% output_test

%%  Normalization

[tr_in, tr_input] = mapminmax(Tr_in, 0, 1);

tr_in = tr_in';

[tr_out, tr_output] = mapminmax(Tr_out, 0, 1);

tr_out = tr_out';

te_in = mapminmax('apply', Te_in, tr_input);

te_in = te_in';

all_in = mapminmax('apply', data(TE(1: 100), Fea )', tr_input);

all_in=all_in';

%%  Random forest model

trees = 200; % Trees

leaf  = 0.1; % Leaves

Method = 'regression';  % regression

net = TreeBagger(trees, tr_in, tr_out,'Method', Method, 'minleaf', leaf);

%%  Predict

tr_pre = predict(net, tr_in );

te_pre = predict(net, te_in );

all_pre = predict(net, all_in );

%%  Anti-normalization

Tr_pre = mapminmax('reverse', tr_pre, tr_output);

Tr_pre =Tr_pre';

Te_pre = mapminmax('reverse', te_pre, tr_output);

Te_pre =Te_pre';

All_pre = mapminmax('reverse', all_pre, tr_output);

%%  Plot

figure

plot(Te_out,Te_pre,'r*')

plot(Tr_out,Tr_pre,'o','LineWidth',2);

hold on

plot(Te_out,Te_pre,'o','LineWidth',2);

set(gca,'FontName','Times New Roman','FontSize',16)

xlabel('True metric','FontName','Times New Roman','FontSize',16)

ylabel('Predicted metric','FontName','Times New Roman','FontSize',16);

plot(0:0.2:1,0:0.2:1,'LineWidth',2);

legend('Train','Test')

%%  Evaluation criteria

All_true=data(TE(1: 100), 29);

error=All_pre'-All_true';

[~,len]=size(All_true');

R2=1-sum((All_true'-All_pre').^2)/sum((mean(All_true')-All_true').^2);

MSE=error*error'/len;

RMSE=MSE^(1/2);

disp(['MSE of dataset：', num2str(MSE)])

disp(['RMSE of dataset：', num2str(RMSE)])

disp(['R2 of dataset：', num2str(R2)])


