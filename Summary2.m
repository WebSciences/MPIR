clear
load('Covariance')
Output=[];

for j=0:9
    filename=strcat('Result0_',num2str(j));
    load(filename);
    result=[];
    
    for i=101:150
    %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores));
            covarianceMatrix=Covariance{i-100};
            Optimal=perform2(scores,covarianceMatrix,optimalDesicion(i,:),relevance);
            result=[result;Optimal];
    %end
    end
    test(j+1).Recall=result(:,1);
    test(j+1).Precision=result(:,2);
    test(j+1).NDCG=result(:,3);
    test(j+1).MRR=result(:,4);
    Output=[Output;sum(result)./50];
end

result=[];
for i=101:150
    %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores));
            covarianceMatrix=Covariance{i-100};
            noExplore=perform2(scores,covarianceMatrix,1:5,relevance);
            result=[result;noExplore];
    %end
end
    test(11).Recall=result(:,1);
    test(11).Precision=result(:,2);
    test(11).NDCG=result(:,3);
    test(11).MRR=result(:,4);
Output=[Output;sum(result)./50];

result=[];
for i=101:150
    %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores));
            covarianceMatrix=Covariance{i-100};
            
            result=[result;metric1(1:200,relevance)];
    %end
end
    test(12).Recall=result(:,1);
    test(12).Precision=result(:,2);
    test(12).NDCG=result(:,3);
    test(12).MRR=result(:,4);
Output=[Output;sum(result)./50];