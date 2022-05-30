function Carbon_emissions = Carbon_emission(destination,new_route_bus_1,new_route_bus_2,center_x1,center_x2)
    %% solid index setting
    Fueltoair_mass_ratio = 1
    Vehicle_drivetrain_efficiency = 0.4
    Heating_value_of_diesel_fuel = 43.2
    Efficiency_parameter_for_diesel_engines = 0.9
    Engine_friction_factor = 0.2
    Engine_speed = 33
    Engine_displacement = 5
    Coefficient_of_aerodynamic_drag = 0.7
    Coefficient_of_rolling_resistance = 0.01
    air_density = 1.2041
    gravitational_constant = 9.81
    road_grade_angle_in_degrees = 0
    acceleration = 0
    Conversion_factor = 737
    
    %% Variable data
    Net_weight_of_vehicle = 6000
    speed = 45
    guest_weight = 50
    
    %% 第一辆
    stage = size(center_x1,1)
    guest_number = 0
    center_x1 = [center_x1;destination]
    Carbon_emission_1 = 0
    location_0 = find(new_route_bus_1 == 0)
    for i = 1 : stage
       stage_distance =  1000*(((center_x1(i,1)-center_x1(i+1,1))^2 + (center_x1(i,2)-center_x1(i+1,2))^2)^0.5 )
       stage_distance = stage_distance * 2.5 %算例需要
       guest_geton = location_0(i+1) - location_0(i)-1
       guest_number = guest_number + guest_geton
       emission_part1 = (Fueltoair_mass_ratio / (Heating_value_of_diesel_fuel*Conversion_factor))*(stage_distance / speed )
       emission_part2 = Engine_friction_factor*Engine_speed*Engine_displacement
       emission_part3 = 0.5*Coefficient_of_aerodynamic_drag*air_density*speed^3
       emission_part4 = (Net_weight_of_vehicle + guest_number*guest_weight) * speed
       emission_part5 = gravitational_constant*sind(road_grade_angle_in_degrees) + gravitational_constant*Coefficient_of_rolling_resistance*cosd(road_grade_angle_in_degrees) + acceleration
       emission_part6 = 1000*Vehicle_drivetrain_efficiency*Efficiency_parameter_for_diesel_engines
       Carbon_emission_s = emission_part1*(emission_part2 + (emission_part3+emission_part4*emission_part5)/emission_part6)
       Carbon_emission_1 = Carbon_emission_1 + Carbon_emission_s
    end
    
    %% 第二辆
    stage = size(center_x2,1)
    guest_number = 0
    center_x2 = [center_x2;destination]
    Carbon_emission_2 = 0
    location_0 = find(new_route_bus_2 == 0)
    for i = 1 : stage
       stage_distance =  1000*(((center_x2(i,1)-center_x2(i+1,1))^2 + (center_x2(i,2)-center_x2(i+1,2))^2)^0.5)
       stage_distance = stage_distance * 2.5 %算例需要
       guest_geton = location_0(i+1) - location_0(i)-1
       guest_number = guest_number + guest_geton
       emission_part1 = (Fueltoair_mass_ratio / (Heating_value_of_diesel_fuel*Conversion_factor))*(stage_distance / speed )
       emission_part2 = Engine_friction_factor*Engine_speed*Engine_displacement
       emission_part3 = 0.5*Coefficient_of_aerodynamic_drag*air_density*speed^3
       emission_part4 = (Net_weight_of_vehicle + guest_number*guest_weight) * speed
       emission_part5 = gravitational_constant*sind(road_grade_angle_in_degrees) + gravitational_constant*Coefficient_of_rolling_resistance*cosd(road_grade_angle_in_degrees) + acceleration
       emission_part6 = 1000*Vehicle_drivetrain_efficiency*Efficiency_parameter_for_diesel_engines
       Carbon_emission_s = emission_part1*(emission_part2 + (emission_part3+emission_part4*emission_part5)/emission_part6)
       Carbon_emission_2 = Carbon_emission_2 + Carbon_emission_s
    end
    
    %% 
    Carbon_emissions = Carbon_emission_1 + Carbon_emission_2
end