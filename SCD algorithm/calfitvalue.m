% 2.3 

function fitvalue=calfitvalue(objvalue)

[px,py]=size(objvalue);

for i=1:px
    if objvalue(i)>0
        temp=objvalue(i);
    else
        temp=0;
    end
    fitvalue(i)=temp;
end

fitvalue=fitvalue';

