function value=ValueFuntion(meanVector,covarianceMatrix,action)

% Value function without tuning parameter

global num;
global top;
global weight;
if isempty(action)
    value=0;
    return;
end


instantReward=weight*meanVector(1:top);
theta=meanVector(action);
sigma=covarianceMatrix(action,action);
sample=mvnrnd(theta,sigma,num);
futureReward=0;
feedback=[action;action]';
for i=1:num
    feedback(:,1)=sample(i,:);
    meanUpdate=BeliefUpdate(meanVector,covarianceMatrix,feedback);
    meanUpdate=sort(meanUpdate,'descend');
    futureReward=futureReward+weight*meanUpdate(1:top);
end
value=futureReward/num+instantReward;
end