function total_distance = distance(center_x1,center_x2,start,destination)
    car1_distance = 0
    car2_distance = 0
    for i = 1 : size(center_x1,1)-1
       distance = ((center_x1(i,1)-center_x1(i+1,1))^2 + (center_x1(i,2)-center_x1(i+1,2))^2)^0.5
       car1_distance = car1_distance + distance    
    end
    s = ((start(1,1)-center_x1(1,1))^2 + (start(1,2)-center_x1(1,2))^2)^0.5
    d = ((destination(1,1)-center_x1(1,1))^2 + (destination(1,2)-center_x1(1,2))^2)^0.5
    car1_distance = car1_distance + s + d
    
    
    for i = 1 : size(center_x2,1)-1
       distance = ((center_x2(i,1)-center_x2(i+1,1))^2 + (center_x2(i,2)-center_x2(i+1,2))^2)^0.5
       car2_distance = car2_distance + distance    
    end
    s = ((start(1,1)-center_x2(1,1))^2 + (start(1,2)-center_x2(1,2))^2)^0.5
    d = ((destination(1,1)-center_x2(1,1))^2 + (destination(1,2)-center_x2(1,2))^2)^0.5
    car2_distance = car2_distance + s + d
    total_distance = car1_distance + car2_distance
end