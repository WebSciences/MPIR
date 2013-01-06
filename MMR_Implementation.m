%{

Run MMR algorithm.

Input: relevance scores,covariance matrix

Output: 
The re-ranking list
The metrics: Recall@1-5,Precision@1-5,NDCG@5,MRR@5

%}
load('Covariance')
Output=[];
rank=15;

for l=0.1:0.1:0.9
    result=zeros(2,4);
    
    for i=101:150
        %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores))*0.5+0.5;
            covarianceMatrix=Covariance{i-100};
            
            index=2:rank;
            select=1;
            for k=2:10
                value=ones(1,rank)*-10;
                for j=index
                    action=[select,j];
                    value(j)=l*scores(j)-(1-l)*max(covarianceMatrix(j,select));
                end
                
                act=find(value==max(value),1);
                select=[select,act]
                index(find(index==act))=[];

            end
            result(1,:)=result(1,:)+metric(ChangeAction2RankList(select(1:5),200),relevance);
            %relevance(select(1:5))=[];
            result(2,:)=result(2,:)+metric(ChangeAction2RankList(select(6:10),195),relevance);
    %end
    end
    Output=[Output;result./50];
end
