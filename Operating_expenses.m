function operation_fee = Operating_expenses(bus_number,distance,time_penalty_fee,population)
  car_fee = bus_number * 50
  Fuel_consumption_per_kilometer = 0.3
  fuel_price = 9.21
  ticket_price = 2
  fuel_fee = fuel_price * Fuel_consumption_per_kilometer * distance
  guest_number = size(find(population ~= 0),2)
  ticket_fee = ticket_price * guest_number
  operation_fee = car_fee + fuel_fee - ticket_fee + time_penalty_fee
end