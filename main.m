
function main()
%% load excel which keep the statistic
x = xlsread('sample1.xlsx')

%% cluster the statistic
Clustering_index = -5
[Clustering_results,center] = improved_AP_algorithm(x,Clustering_index)

%% index
bus_number = 2
bus_capacity = 25
population_quantity = 30 
initial_population = []  
starting = [0 0]         
destination = [4 4]      
distances = []  
bus_penalty_cost = [] 
multiple_target = []
speed = 40 
time_penalty_index = 0.1  

%% Multi objective results
switch bus_number
    case 2
        for i = 1 : population_quantity
            [bus_1_route,bus_2_route] = two_bus_route(Clustering_results)
            [guest_number_bus_1,guest_number_bus_2] = guest_number_2(bus_1_route,bus_2_route,x)
            if guest_number_bus_1 > bus_capacity || guest_number_bus_2 > bus_capacity
                [bus_1_route,bus_2_route] = arrange_route(bus_1_route,bus_2_route,guest_number_bus_1,guest_number_bus_2,bus_capacity,x)       
            end
            population = [bus_1_route 0 bus_2_route]
            initial_population = initial(x,initial_population,population)   
            [new_route_bus_1,new_route_bus_2,center_x1,center_x2] = new_route(population,x,Clustering_index)
            Carbon_emissions = Carbon_emission(destination,new_route_bus_1,new_route_bus_2,center_x1,center_x2)
            [time_penalty_fee,delay_time] = time_penalty(new_route_bus_1,new_route_bus_2,center_x1,center_x2,destination,x,speed,time_penalty_index)
            total_distance = distance(center_x1,center_x2,starting,destination)
            %distances = [distances;total_distance]                          
            bus_penalty_cost = [bus_penalty_cost;time_penalty_fee]
            operation_fee = Operating_expenses(bus_number,total_distance,time_penalty_fee,population)
            multiple_target = [multiple_target;operation_fee delay_time Carbon_emissions]
        end
       
end

