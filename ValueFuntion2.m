function value=ValueFuntion2(meanVector,covarianceMatrix,action,alpha)

% Value function with tunring parameter
global num;
global top;
global weight;
if isempty(action)
    value=0;
    return;
end

rankList=ChangeAction2RankList(action,length(meanVector));
instantReward=weight*meanVector(rankList(1:top));
theta=meanVector(action);
sigma=covarianceMatrix(action,action);
sample=mvnrnd(theta,sigma,num);

feedback=[action;action]';
[judgement,prob]=CreatPro(sample,3);
futureReward=zeros(1,size(judgement,1));
for i=1:size(judgement,1)
    if prob(i)>0.001
        feedback(:,1)=judgement(i,:);
        meanUpdate=BeliefUpdate(meanVector,covarianceMatrix,feedback);
        meanUpdate=sort(meanUpdate,'descend');
        futureReward(i)=weight*meanUpdate(1:top);
    end
end

value=alpha*instantReward+(1-alpha)*futureReward*prob;
end