% 2.2

function [objvalue]=calobjvalue(popsize,pop,Data_ela,net,ps_input,ps_output)

group_1=pop(:,1:2);

ratio_1=pop(:,3:6);

group_2=pop(:,7:10); 

ratio_2=pop(:,11:14); 

group_3=pop(:,15:19); 

Group_1=decodechrom(group_1,1,2); 

for i=1:popsize
    if Group_1(i) == 0
        Group_1(i)=1;
        i=i+1;
    else
        i=i+1;
    end
end

Ratio_1=decodechrom(ratio_1,1,4)/10;

for i=1:popsize
    if Ratio_1(i) == 0
        Ratio_1(i)=0.1;
        i=i+1;
    else
        i=i+1;
    end
end

Group_2=decodechrom(group_2,1,4);

for i=1:popsize
    if Group_2(i) > 12 || Group_2(i) == 0
        Group_2(i)=1;
        i=i+1;
    else
        i=i+1;
    end
end

Ratio_2=decodechrom(ratio_2,1,4)/10;

for i=1:popsize
    if Ratio_2(i) == 0
        Ratio_2(i)=0.1;
        i=i+1;
    else
        i=i+1;
    end
end
Group_3=decodechrom(group_3,1,5); 

for i=1:popsize
    if Group_3(i) > 23 || Group_3(i) == 0
        Group_3(i)=1;
        i=i+1;
    else
        i=i+1;
    end
end

Ratio_3=1-Ratio_1-Ratio_2;      
for i=1:popsize
    if Ratio_3(i) < 0
        Ratio_1(i)=0.1;
        Ratio_2(i)=0.1;
        Ratio_3(i)=0.8;
        i=i+1;
    else
        i=i+1;
    end
end

Ele_1=Data_ela(Group_1,:);

Ele_2=Data_ela(Group_2+3,:);

Ele_3=Data_ela(Group_3+15,:);

E=Ratio_1.*Ele_1+Ratio_2.*Ele_2+Ratio_3.*Ele_3; 

input = mapminmax('apply', E', ps_input);  

Input=input';

Pre = predict(net, Input);

output = mapminmax('reverse', Pre, ps_output); 

Output =output';

objvalue=Output';  
