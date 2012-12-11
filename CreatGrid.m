function grid=CreatGrid(selectNum,scale)

grid=zeros(scale^selectNum,selectNum);

format=['%.',num2str(selectNum),'d'];
for i=0:scale^selectNum-1
    num=num2str(str2double(dec2base(i,scale)),format);
    for j=1:selectNum
        
        grid(i+1,j)=str2double(num(j));
    end
end

end


