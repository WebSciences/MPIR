function result=perform(meanVector,covarianceMatrix,action,relevance)
%{
	Function: Perform 2-period IR

	Input: 	meanvector-- BM25 score
            Covariance matrix
			action -- the index of document ranked in the first page
			relevance -- true relevance scores

	Output:	metrics for both first and second stage
%}

rankedList=ChangeAction2RankList(action,length(meanVector));

% metrics for the first page
result=metric(rankedList,relevance);

% Update the belief state
feedback=[relevance(action),action'];
relevance(action)=[];
[~,action]=sort(BeliefUpdate(meanVector,covarianceMatrix,feedback),'descend');
%%rankedList=ChangeAction2RankList(action);

% metrics for the second stage
result=[result;metric(action,relevance)];
end
