testResult=zeros(11,4);
for i=1:11
    r=12;
    testResult(i,1)=signrank(test(i).Recall,test(r).Recall);
    testResult(i,2)=signrank(test(i).Precision,test(r).Precision);
    testResult(i,3)=signrank(test(i).NDCG,test(r).NDCG);
    testResult(i,4)=signrank(test(i).MRR,test(r).MRR);
    
end
    
