% 2.4

function [newpop]=division(pop,fitvalue)

totalfit=sum(fitvalue);                    %求适应值之和

fitvalue=fitvalue/totalfit;                %单个个体被选择的概率

fitvalue=cumsum(fitvalue);                 %如 fitvalue=[1 2 3 4]，则 cumsum(fitvalue)=[1 3 6 10]

[px,py]=size(pop);                         %20*10

ms=sort(rand(px,1));                       %从小到大排列

fitin=1;

newin=1;

while newin<=px                            %选出20个新个体，有重复情况，和上面介绍的方法不太一样
    if(ms(newin))<fitvalue(fitin)
        newpop(newin,:)=pop(fitin,:);
        newin=newin+1;
    else
        fitin=fitin+1;
    end
end