function plot_lines(x,class,centre)
    n = length(class);
    figure(1);
    hold on;
           
    for i = 1 : n
        pos = class(i);
        plot([x(i,1),centre(pos,1)], [x(i,2), centre(pos,2)],'g--');
        pause(0.05);
    end
    
end