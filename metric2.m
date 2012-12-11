function metrics=metric(rankedList,relevance)
right=0;
recall=zeros(1,5);
precision=zeros(1,5);
full=sum(sign(relevance));
DCG=0;
LDCG=0;
NDCG=0;
[~,optiamlRankedList]=sort(relevance,'descend');

if full>0
for i=1:5
    if relevance(rankedList(i))>=1
        right=right+1;
        
    end
    DCG=DCG+(2^relevance(rankedList(i))-1)/log2(i+1);
    LDCG=LDCG+(2^relevance(optiamlRankedList(i))-1)/log2(i+1);
    recall(i)=right/full;
    precision(i)=right/i;
end
end
if LDCG~=0
    NDCG=DCG/LDCG;
end


metrics=[recall,precision,NDCG];
end