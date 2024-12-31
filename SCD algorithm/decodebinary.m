% 2.2.2

function pop2=decodebinary(pop)

[px,py]=size(pop);

for i=1:py
    pop1(:,i)=2.^(py-i).*pop(:,i);
end

pop2=sum(pop1,2);


