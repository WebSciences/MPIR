%{
The main code

Input: relevance scores,covariance matrix

Parameter 
weight: rank bias
Rank: choose the content of first page from 1:rank documents.
num: Monte Carlo sampling size.
selectNum: the number of documents in first page.
l: tuning parameter

Output:
The re-ranking list
The metrics: Recall@1-5,Precision@1-5,NDCG@5,MRR@5
%}

clear all;
global num;
global top;
global weight gridMatrix;
top=15;
num=5000;
weight=log2(2:top+1).^-1;
rank=15;
selectNum=5;
load('grid');
gridMatrix=grid;
load('Result');
load('Covariance') % Load covariance matrixes
topic=101:150;

for l=0.1:0.1:0.9
for i=101:150
    
%Step 1: for each topic, load relevance score and covariance matrix for rank@1-200 documents 

    path=strcat('c:\WT10G\',num2str(i),'.txt');
    data=load(path);
    scores=data(:,1);
    relevance=data(:,2);
    scores=scores.^2;
    scores=(scores-min(scores))/(max(scores)-min(scores));
    covarianceMatrix=Covariance{i-100};

%Step 2: run re-ranking algorithm, choose the optimal ranking action from rank 1 to selectNum.
    index=1:rank;
    select=[];
    %%lastStep=0;
    for k=1:selectNum
        value=zeros(1,rank);
        for j=index
            action=[select,j];
            value(j)=ValueFuntion2(scores,covarianceMatrix,action,l/10);
        end
        act=find(value==max(value));
        select=[select,act]
        index(find(index==act))=[];
    end

    % output result:   
    %noExplore=perform(scores,covarianceMatrix,1:5,relevance);
    Optimal=perform(scores,covarianceMatrix,select,relevance);
    
    optimalDesicion(i,:)=select;
    Result{i}=[Optimal];  
end
filename=strcat('Result0_',num2str(l));
save(filename,'Result','optimalDesicion');
end





