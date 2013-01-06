function [judgement,prob]=CreatPro(sample,scale)


[n,selectNum]=size(sample);
global gridMatrix;

sample=round(sample);
sample(sample<0)=0;

sample(sample>(scale-1))=scale-1;

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


