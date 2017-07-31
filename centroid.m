function centre = centroid(x,classes)
    
    k = ver_classes(classes);
    centre = zeros(k,size(x,2));
    
    for c = 1:k
        y = x(classes == c,:);
        %centros(c,:) = sum(y)/size(y,1);
        centre(c,:) = mean(y);
    end
end