require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
# Using the Time class object to publish the date
today_date = Time.new
puts today_date.strftime("\nToday's Date: %d/%m/%Y")

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price
products_hash["items"].each do | toy_name |
  # Print the name of the toy
  puts "\nProduct: #{toy_name["title"]}"
  puts "***************************************"

  # Print the retail price of the toy
  # Assigning the retail price to a variable as this needs to be used later 
  retail_pr = toy_name["full-price"]
  puts "Retail Price: $#{retail_pr}"

  # Calculate and print the total number of purchases
  # Assigning the total to a variable as this needs to be used later 
  tot_pur = toy_name["purchases"].length
  puts "Total Number of Purchases: #{tot_pur}"

  # Calculate and print the total amount of sales
  # Create a new array with all prices in the purchases array and using the inject method from Enumerator-
  # class to sum the items in the price array
  price_only = toy_name["purchases"].map {| my_price | my_price["price"]}
  puts "Total Sales Amount: $#{price_only.inject(:+)}" 
  
  # Calculate and print the average price the toy sold for
  # # Assigning the Average price to a variable as this needs to be used later 
  avg_price = price_only.inject(:+)/tot_pur
  puts "Average Price: $#{avg_price}"

  # Average discount price in $
  avg_price_dis = retail_pr.to_f - avg_price
  puts "Average Discount: $#{avg_price_dis}"

  # Calculate and print the average discount (% or $) based off the average sales price
  puts "Average Discount Percentage: #{(avg_price_dis/retail_pr.to_f * 100).round(2)}%"

end

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

# Populate the unique brands into another array
products_brand = (products_hash["items"].map {|each_brand| each_brand["brand"]}).uniq

products_brand.each do | toy_brand |
  # Print the name of the brand
  puts "\nBrand: #{toy_brand}"
  puts "***************************************"

  # Count and print the number of the brand's toys we stock
  # put into the array everything for 1 type of brand
  stock_array = products_hash["items"].select {|item| toy_brand == item["brand"]}   
  # extract the stock number from the array
  stock_total = stock_array.map {| one_stock | one_stock["stock"]}
  puts "Number of Products: #{stock_total.inject(:+)}"  
  
  # Calculate and print the average price of the brand's toys
  # extract the full price from the array
  price_total = stock_array.map {| one_stock | one_stock["full-price"].to_f}
  puts "Average Product Price: $#{(price_total.inject(:+)/price_total.length).round(2)}"

  # Calculate and print the total revenue of all the brand's toy sales combined
  # put into the array all the relevant purchases for each brand
  stock_purchase = stock_array.map {|each_purchase| each_purchase["purchases"]}
  # initialize counters and array to loop through the number of purchases
  out_counter = 0 
  in_counter = 0
  total_purchase = Array.new
  # first loop for purchases array
  while out_counter < stock_purchase.length
    # 2nd loop for within purchases
    while in_counter < stock_purchase[out_counter].length
      total_purchase.push(stock_purchase[out_counter][in_counter]["price"])
      in_counter += 1
    end
    out_counter += 1
    # reset in_counter to 0
    in_counter = 0
  end

  puts "Total Sales: $#{total_purchase.inject(:+).round(2)}"
end

