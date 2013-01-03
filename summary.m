load('Covariance')
Output=[];

% Compute the metrics for both first and second pages for tunring paramter from 0 to 0.9
for j=0:9
    filename=strcat('Result0_',num2str(j));
    load(filename);
    result=zeros(2,4);
    j
    for i=101:150
    %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores));
            covarianceMatrix=Covariance{i-100};
            Optimal=perform(scores,covarianceMatrix,optimalDesicion(i,:),relevance);
            result=result+Optimal;
    %end
    end
    Output=[Output;result./50];
end

%%%%%%%%%%%%%%%%%%
% Compute the metrics for both first and second pages using conventional algorithm
% The first page
result=zeros(2,4);
for i=101:150
    %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores));
            covarianceMatrix=Covariance{i-100};
            noExplore=perform(scores,covarianceMatrix,1:5,relevance);
            result=result+noExplore;
    %end
end
Output=[Output;result./50];

% The second page
result=zeros(1,4);
for i=101:150
    %if isempty(Result{i})==0
            path=strcat('c:\WT10G\',num2str(i),'.txt');
            data=load(path);
            scores=data(:,1);
            relevance=data(:,2);
            scores=scores.^2;
            scores=(scores-min(scores))/(max(scores)-min(scores));
            covarianceMatrix=Covariance{i-100};
            
            result=result+[metric(1:195,relevance(6:end))];
    %end
end
Output=[Output;result./50];



