clear; clc; close all;

% Construct data set
x = class5(10);

k = 5;
max_it = 10;

low = 1;
high = size(x,1);
centre = zeros(k,size(x,2));
index = zeros(1,k);

for var = 1:k
    index(var) = round(low + (high - low)*rand);
    centre(var,:) = x(index(var),:);
end

class = zeros(high,1);

var_cond = 1;
W = 1;

while W

    dist = zeros(high,k);
    for var = 1:high
        for c = 1:k
            sumNum = 0;
            for s = 1:size(x,2)
                sumNum = sumNum + (x(var,s) - centre(c,s)).^2;
            end
            dist(var,c) = sqrt(sumNum);
        end
    end
     
    old_class = class;
    
    for var = 1:high
        [~,index] = min(dist(var,:));
         class(var) = index;
    end
    
    colours = rand(k,3);
    clf;

    n = length(class); 
    figure(1);    
    hold on;          
    
    for i = 1 : n         
        p = plot(x(i,1), x(i,2),'mx','LineWidth',3);         
        set(p, 'color', colours(class(i),:))    
    end
    
    pause(1);
    plotCentroid(centre);
    plot_lines(x,class,centre);
    pause(1);
    
    new_class = class;
        
    % Calculate new centroid
    for c = 1:k
        y = x(class == c,:);
        centre(c,:) = sum(y)/size(y,1);
    end
    
    if old_class == new_class
        W = 0;
    end
    
    if var_cond > max_it
        W = 0;
    end
        
    var_cond = var_cond + 1;
end


class = new_class;
num_it = var_cond;

colours = rand(k,3);

figure(1);
hold on;
for i = 1: length(x)
    p = plot(x(i,1), x(i,2),'mx','LineWidth',3');
    set(p, 'color', colours(class(i),:))
end