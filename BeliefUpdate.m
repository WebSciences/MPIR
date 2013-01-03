function [meanUpdated,covarianceUpdated]=BeliefUpdate(meanVector,covarianceMatrix,feedbackInf)

%{ This function is used to compute the conditional distribution given the relevance feedback of some documents.

Input: feedbackInf is a K*2 matrix (K is the number of feedback). The first row presents the relevance scores provided by the user; the second row show the corresponding index.

Output: updated belief state

Note: The documents in the first page are exculded from the output meanvector and covariance matrix.
}%


docNumber=length(meanVector);
feedbackIndex=feedbackInf(:,2);
remainIndex=1:docNumber;
remainIndex(feedbackIndex)=[];
meanUpdated=zeros(docNumber,1);
covarianceUpdated=covarianceMatrix;

theta=meanVector(remainIndex);

sigma11=covarianceMatrix(remainIndex,remainIndex);
sigma22=covarianceMatrix(feedbackIndex,feedbackIndex);
sigma12=covarianceMatrix(remainIndex,feedbackIndex);

thetaUpdate=theta+sigma12*pinv(sigma22)*(feedbackInf(:,1)-meanVector(feedbackIndex));

%meanUpdated(remainIndex)=thetaUpdate;
%meanUpdated(feedbackIndex)=feedbackInf(:,1)-feedbackInf(:,1);
meanUpdated=thetaUpdate;

sigmaUpdated=sigma11-sigma12*pinv(sigma22)*sigma12';
covarianceUpdated(remainIndex,remainIndex)=sigmaUpdated;


end
