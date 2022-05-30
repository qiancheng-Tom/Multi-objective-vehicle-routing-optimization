function [bus_1_route,bus_2_route] = two_bus_route(Clustering_results)
        


        sum_station = size(find(Clustering_results==0),2)-1
        location_0 = find(Clustering_results == 0)
        location_0(size(location_0,2)) = []

        stationnumber_bus_1 = ceil(rand*(sum_station-1))
        stationnumber_bus_2 = sum_station-stationnumber_bus_1
        pick_up_number = [stationnumber_bus_1 stationnumber_bus_2]
        
        pickup_bus_1 = location_0(randperm(numel(location_0),stationnumber_bus_1))
        pickup_bus_1 = sort(pickup_bus_1)
        a = [pickup_bus_1 location_0] 
        pickup_bus_2 = a(sum(bsxfun(@eq,a(:),a(:).'))==1)
       
        bus_1_route = []
        for i = 1 : size(pickup_bus_1,2)
            g = find(location_0 == pickup_bus_1(1,i))
            if g < size(location_0,2)
                w = Clustering_results(1,location_0(1,g):location_0(1,g+1)-1)
            else
                w = Clustering_results(1,location_0(1,g):size(Clustering_results,2))
            end
            bus_1_route = [bus_1_route w]
        end
        
        bus_2_route = []
         for i = 1 : size(pickup_bus_2,2)
            g = find(location_0 == pickup_bus_2(1,i))
            if g < size(location_0,2)
                w = Clustering_results(1,location_0(1,g):location_0(1,g+1)-1)
            else
                w = Clustering_results(1,location_0(1,g):size(Clustering_results,2))
            end
            bus_2_route = [bus_2_route w]
         end
        
         if bus_1_route(1,size(bus_1_route,2)) ~= 0
            bus_1_route = [bus_1_route 0]
         end
         if bus_2_route(1,size(bus_2_route,2)) ~= 0
            bus_2_route = [bus_2_route 0]
         end
         bus_1_route(bus_1_route == 0) = []
         bus_2_route(bus_2_route == 0) = []
end