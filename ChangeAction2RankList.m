function rankList=ChangeAction2RankList(action,total)
% Function: convert the action (selecting documents into the first page) to a full ranking list.

rankList=1:total;
rankList(action)=[];
rankList=[action,rankList];
end