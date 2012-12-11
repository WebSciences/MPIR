function [meanUpdated,covarianceUpdated]=BeliefUpdate2(meanVector,covarianceMatrix,feedbackInf)
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

meanUpdated(remainIndex)=thetaUpdate;
meanUpdated(feedbackIndex)=104:-1:100;
%meanUpdated=thetaUpdate;

sigmaUpdated=sigma11-sigma12*pinv(sigma22)*sigma12';
covarianceUpdated(remainIndex,remainIndex)=sigmaUpdated;


end
