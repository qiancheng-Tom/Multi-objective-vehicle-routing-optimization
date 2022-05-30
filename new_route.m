function [new_route_bus_1,new_route_bus_2,center_x1,center_x2] = new_route(population,x,p)
    x_1 = []
    x_2 = []
    g = find(population == 0)
    bus_1 = population(1,1:g-1)
    bus_2 = population(1,g+1:size(population,2))
    
    for i = 1 : size(bus_1,2)
       information_1 = x(bus_1(i),:)
       x_1 = [x_1;information_1]
    end
    for j = 1 : size(bus_2,2)
       information_2 = x(bus_2(j),:)
       x_2 = [x_2;information_2]
    end
    
    [Clustering_results_x1,center_x1] = improved_AP_algorithm(x_1,p) %第一辆车
    [Clustering_results_x2,center_x2] = improved_AP_algorithm(x_2,p) %第二辆车
    h1 = find(Clustering_results_x1 ~= 0)
    h2 = find(Clustering_results_x2 ~= 0)
    for i = 1 : size(h1,2)
         Clustering_results_x1(h1(i)) = x_1(i,4)
    end
    for i = 1 : size(h2,2)
         Clustering_results_x2(h2(i)) = x_2(i,4)
    end
    new_route_bus_1 = Clustering_results_x1
    new_route_bus_2 = Clustering_results_x2
end