function value=ValueFuntion2(meanVector,covarianceMatrix,action,alpha)

% Value function with tunring parameter
%{
This function is used to compute the value function for a given belief state and an action.

Input: meanVector -- the relevance score of ranked documents
	 covarianceMatrix -- the similarity matrix
	 action -- re-ranking in the first page
	 alpha -- tunring parameter

Output: The expected total return
%}

	

global num;
global top;
global weight;
if isempty(action)
    value=0;
    return;
end

rankList=ChangeAction2RankList(action,length(meanVector));
instantReward=weight*meanVector(rankList(1:top));

% MC sampling
theta=meanVector(action);
sigma=covarianceMatrix(action,action);
sample=mvnrnd(theta,sigma,num);

feedback=[action;action]';

% Compute the probability of each possible judgement
[judgement,prob]=CreatPro(sample,3);
futureReward=zeros(1,size(judgement,1));
for i=1:size(judgement,1)
    if prob(i)>0.001 % Filter judgments having very low probability
        feedback(:,1)=judgement(i,:);
        meanUpdate=BeliefUpdate(meanVector,covarianceMatrix,feedback);
        meanUpdate=sort(meanUpdate,'descend');
        futureReward(i)=weight*meanUpdate(1:top);
    end
end

% Expected total return
value=alpha*instantReward+(1-alpha)*futureReward*prob;
end