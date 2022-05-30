function initial_population = initial(x,initial_population,population)
     
     
     if size(population,2) < size(x,1)+1
          rest = size(x,1) - size(population,2)+1
          supplement = zeros(1,rest)
          population = [population supplement]
     end
     initial_population = [initial_population;population]
end