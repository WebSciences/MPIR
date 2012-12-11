function output=increase(vector)
l=length(vector)/2;
for i=1:l
    output(i)=(vector(2*i)-vector(2*i-1))/vector(2*i-1);
end

