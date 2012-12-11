function rankList=ChangeAction2RankList(action,total)
rankList=1:total;
rankList(action)=[];
rankList=[action,rankList];
end