function [bus_1_number,bus_2_number] = guest_number_2(bus_1_route,bus_2_route,statistic)
     bus_1_route(bus_1_route == 0) = []
     bus_1_number = 0
     bus_2_number = 0
     for i = 1 : size(bus_1_route,2)
          number =  statistic(bus_1_route(1,i),3)
          bus_1_number = bus_1_number + number
     end
         
     bus_2_route(bus_2_route == 0) = []
     for i = 1 : size(bus_2_route,2)
          number =  statistic(bus_2_route(1,i),3)
          bus_2_number = bus_2_number + number
     end

end