% 2.5

function [newpop]=differentiation(pop,fitvalue)   
    
[px,py]=size(pop);

newpop=ones(size(pop));

totalfit=sum(fitvalue);   %求适应值之和

for a=1:px
    pc(a)=fitvalue(a)/totalfit;
end

for k=1:py
    pd(k)=sum(pop(:,k)==1)/px;
end

for i=1:px
    for j=1:py
        p(i,j)=rand;
        if(p(i,j)<pd(j)*(1-pc(i)))
            newpop(i,j)=1;
        elseif(p(i,j)>=pd(j)*(1-pc(i)) && p(i,j)<1-(pc(i))*(1-pd(j)))
            newpop(i,j)=0;
        else
            newpop(i,j)=pop(i,j);
        end
    end
end