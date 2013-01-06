function metrics=metric(rankedList,relevance)
%{

Function: Calculate recall,precision,NDCG and MRR

Input: Ranking and relevance scores

Output: metrics

%}


right=0;
recall=0;
precision=0;
full=sum(sign(relevance));
DCG=0;
LDCG=0;
NDCG=0;
MRR=0;
[~,optiamlRankedList]=sort(relevance,'descend');

if full>0
for i=1:5
    if relevance(rankedList(i))>=1
        right=right+1;
        
    end
    DCG=DCG+(relevance(rankedList(i)))/log2(i+1);
    LDCG=LDCG+(relevance(optiamlRankedList(i)))/log2(i+1);
end

for i=1:5
    if relevance(rankedList(i))>=1
        MRR=1/i;
        break;
    end
end

recall=right/full;
precision=right/5;
end


if LDCG~=0
    NDCG=DCG/LDCG;
end


metrics=[recall,precision,NDCG,MRR];
end