% Power system Laboratory-II,
% M.Tech. (Power System Engineering)
% VSSUT Burla
% Modified By: Dr. Rajat Kanti Samal
% Date: 02-Jan-2023
 
%MATLAB program for optimum unit commitment by brute force method
clear all;
%alpha and beta arrays denote alpha beta coefficients for given generators
alpha=[0.77 1.60 2.00 2.50]';
beta=[23.5 26.5 30.0 32.0]';
pgmin=[1 1 1 1]';
pgmax=[12 12 12 12]';
n=9;
%n denotes total MW to be committed
min=inf;
cost=0;
for i=0:n
    for j=0:n
        for k=0:n
            for l=0:n
                unit=[0 0 0 0];
                 %here we eliminate straightway those combinations which don't
                % make up the n MW demand or such combinations where maximum generation
                % on individual generation is exceeding the maximum capacity of any of the generators
                if(i+j+k+l)==n && i<pgmax(1)&& j<pgmax(2)&& k<pgmax(3)&& l<pgmax(4)
                    if i~=0
                        unit(1,1)=i;
                        %find out cost of generating these units and add it
                        %up to total cost
                        cost=cost+0.5*alpha(1)*i*i+beta(1)*i;
                    end
                        if j~=0
                            unit(1,2)=j;
                            unit(1,2)=j;
                            cost=cost+0.5*alpha(2)*j*j+beta(2)*j;
                        end
                            if k~=0
                                unit(1,3)=k;
                                cost=cost+0.5*alpha(3)*k*k+beta(3)*k;
                            end
                             if l~=0
                                 unit(1,4)=l;
                                 cost=cost+0.5*alpha(4)*l*l+beta(4)*l;
                             end
                             %if total cost is coming out to be less than minimum of the
                             %cost in previous combinations then make min equal to to cost and
                             %cunit(stand for committed units) equal to units
                             %committed in this iteration
                             %(denoted by variable units)
                             if cost<min
                                 cunit=unit;
                                 min=cost;
                             else
                                 cost=0;
                             end
                end
            end
        end
    end
end
disp('cunit display the no.of committed units on each of the four generators');
disp('if cunit for particular generator is 0 it means the unit is not committed');
disp('the total no of units to be committed are');
cunit
