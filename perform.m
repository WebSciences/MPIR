function result=perform(meanVector,covarianceMatrix,action,relevance)
rankedList=ChangeAction2RankList(action,length(meanVector));
result=metric(rankedList,relevance);
feedback=[relevance(action),action'];
relevance(action)=[];
[~,action]=sort(BeliefUpdate(meanVector,covarianceMatrix,feedback),'descend');
%%rankedList=ChangeAction2RankList(action);
result=[result;metric(action,relevance)];
end
