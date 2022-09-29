local selected_number
local total_sum = 0
local amount_selected_numbers = 0

while selected_number ~= 0 do
  print('+--------------------------+')
  print('Select a number between 1 and 9, including 1 and 9. Press 0 to get the total average')
  print('+--------------------------+')
  selected_number = tonumber(io.read())
  
  if selected_number ~= 0 then
    total_sum = total_sum + selected_number
    amount_selected_numbers = amount_selected_numbers + 1
  end
end

local final_average = total_sum / amount_selected_numbers

print('Total average of all selected numbers equals '..final_average)
print("That's it. Thank you, bye!")