require_relative 'item'
require 'byebug'

class Output
  attr_reader :items

  def initialize(items)
    items.map! do |item|
      item = Item.new(item[:quantity], item[:product], item[:price])
    end
    @items = items
  end

  def total_price
    sum = 0
    items.each do |item|
      sum += item.amount_with_taxes
    end
    return sum
  end

  def total_sales_tax
    sum = 0
    items.each do |item|
      sum += item.taxes
    end
    return sum
  end

  def print_item
    items.each do |item|
      puts item.print_item
    end
  end

  def price_total
    puts "Sales Taxes: #{'%.2f' % total_sales_tax} Total: #{'%.2f' % total_price}"
  end
end



# ===================================================================== #
items1 =  [
            {quantity: 1, product: "book", price: 12.49},
            {quantity: 1, product: "music cd", price: 14.99},
            {quantity: 1, product: "chocolate bar", price: 0.85}
          ]

output1 = Output.new(items1)
output1.print_item
output1.price_total

puts "==================================================="

items2 =  [
            {quantity: 1, product: "imported box of chocolates", price: 10.00},
            {quantity: 1, product: "imported bottle of perfume", price: 47.50}
          ]

output2 = Output.new(items2)
output2.print_item
output2.price_total

puts "==================================================="

items3 =  [
            {quantity: 1, product: "imported bottle of perfume", price: 27.99},
            {quantity: 1, product: "bottle of perfume", price: 18.99},
            {quantity: 1, product: "packet of headache pills", price: 9.75},
            {quantity: 1, product: "box of imported chocolates", price: 11.25}
          ]

output3 = Output.new(items3)
output3.print_item
output3.price_total
