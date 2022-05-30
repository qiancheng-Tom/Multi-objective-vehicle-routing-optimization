function [improved_bus_1_route,improved_bus_2_route] = arrange_route(bus_1_route,bus_2_route,guest_number_bus_1,guest_number_bus_2,capacity,x)
    p = rand
    time = 1
    while time
    if  guest_number_bus_1 > capacity
       if p < 0.2
           g = ceil(rand*size(bus_1_route,2))
           bus_1_route(g) = []
       else p >= 0.2
           g = ceil(rand*size(bus_1_route,2))
           guest = bus_1_route(1,g)
           bus_1_route(g) = []
           bus_2_route = [guest bus_2_route]
       end
       [guest_number_bus_1,guest_number_bus_2] = guest_number_2(bus_1_route,bus_2_route,x)
    end
    if  guest_number_bus_2 > capacity
       if p < 0.2
           g = ceil(rand*size(bus_2_route,2))
           bus_2_route(g) = []
       else p >= 0.2
           g = ceil(rand*size(bus_2_route,2))
           guest = bus_2_route(1,g)
           bus_2_route(g) = []
           bus_1_route = [guest bus_1_route]
       end
       [guest_number_bus_1,guest_number_bus_2] = guest_number_2(bus_1_route,bus_2_route,x)
    end
    if guest_number_bus_1 <= capacity && guest_number_bus_2 <= capacity
       time = 0
    end
    end
    bus_1_route(bus_1_route == 0) = []
    bus_2_route(bus_2_route == 0) = []
    improved_bus_1_route = bus_1_route
    improved_bus_2_route = bus_2_route
end