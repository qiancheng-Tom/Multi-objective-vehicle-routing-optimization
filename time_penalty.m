function [time_penalty_fee,delay_time] = time_penalty(route_x1,route_x2,center_x1,center_x2,destination,x,speed,index)
    h = find(route_x1 ~= 0)
    time_penalty_fee_1 = 0
    delay_time_1 = 0
    starting_time_1 = x(route_x1(h(1,1)),5)
    for i = 1 : size(center_x1,1)-1
        two_point_distance = ((center_x1(i,1)-center_x1(i+1,1))^2 + (center_x1(i,2)-center_x1(i+1,2))^2)^0.5
        two_point_distance = two_point_distance * 2.5 %算例需要，实例应删除
        time = two_point_distance * 1000 * 3.6 / (speed * 60)
        starting_time_1 = starting_time_1 + time
        next_time = x(route_x1(h(i+1)),5)
        if starting_time_1 <= next_time
            starting_time_1 = next_time
            fee = 0
        elseif starting_time_1 > next_time
            fee = index * (starting_time_1 - next_time) * x(route_x1(h(i+1)),3)
            extra_time = starting_time_1 - next_time
            delay_time_1 = delay_time_1 + extra_time
        end
        time_penalty_fee_1 = time_penalty_fee_1 + fee
    end
    length = ((center_x1(size(center_x1,1),1)-destination(1,1))^2 + (center_x1(size(center_x1,1),2)-destination(1,2))^2)^0.5
    time = length * 1000 * 3.6 / (speed * 60)
    final_time_1 = starting_time_1 + time
    for i = 1 : size(center_x1,1)
        arrival_time_1 = x(route_x1(h(1,i)),6)
        if arrival_time_1 < final_time_1
            fee = index * (final_time_1 - arrival_time_1) * x(route_x1(h(i)),3)
            time_penalty_fee_1 = time_penalty_fee_1 + fee
        end
    end
    
    
    h = find(route_x2 ~= 0)
    time_penalty_fee_2 = 0
    delay_time_2 = 0
    starting_time_2 = x(route_x2(h(1,1)),5)
    for i = 1 : size(center_x2,1)-1
        two_point_distance = ((center_x2(i,1)-center_x2(i+1,1))^2 + (center_x2(i,2)-center_x2(i+1,2))^2)^0.5
        two_point_distance = two_point_distance * 2.5 %算例需要，实例应删除
        time = two_point_distance * 1000 * 3.6 / (speed * 60)
        starting_time_2 = starting_time_2 + time
        next_time = x(route_x2(h(i+1)),5)
        if starting_time_2 <= next_time
            starting_time_2 = next_time
            fee = 0
        elseif starting_time_2 > next_time
            fee = index * (starting_time_2 - next_time) * x(route_x2(h(i+1)),3)
            extra_time = starting_time_2 - next_time
            delay_time_2 = delay_time_2 + extra_time
        end
        time_penalty_fee_2 = time_penalty_fee_2 + fee
    end
    length = ((center_x2(size(center_x2,1),1)-destination(1,1))^2 + (center_x2(size(center_x2,1),2)-destination(1,2))^2)^0.5
    time = length * 1000 * 3.6 / (speed * 60)
    final_time_2 = starting_time_2 + time
    for i = 1 : size(center_x2,1)
        arrival_time_2 = x(route_x2(h(1,i)),6)
        if arrival_time_2 < final_time_2
            fee = index * (final_time_2 - arrival_time_2) * x(route_x2(h(i)),3)
            time_penalty_fee_2 = time_penalty_fee_2 + fee
        end
    end
    delay_time = delay_time_1 + delay_time_2
    time_penalty_fee = time_penalty_fee_1 + time_penalty_fee_2
end