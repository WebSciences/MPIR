function covariance=Correlation2Covariance(variance,correlation)
% Function: convert similarity measures to a covariance matrix
l=size(correlation);
covariance=zeros(l);
for i=1:l
    for j=1:i-1
        covariance(i,j)=correlation(i,j)*sqrt(variance(i))*sqrt(variance(j));
    end
end
covariance=covariance+covariance'+diag(variance);
end