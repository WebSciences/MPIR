function [judgement,prob]=CreatPro(sample,scale)
[n,selectNum]=size(sample);
global gridMatrix;

sample=round(sample);
temp=sample<0;
sample=sample+temp;
temp=sample>(scale-1);
sample=sample-temp;
fallIn=zeros(scale^selectNum,1);
for i=1:n
    for j=1:scale^selectNum
        if isequal(sample(i,:),gridMatrix{selectNum}(j,:))
            fallIn(j)=fallIn(j)+1;
        end
    end
end
judgement=gridMatrix{selectNum};
prob=fallIn./sum(fallIn);
end


