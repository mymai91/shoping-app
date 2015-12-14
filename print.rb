class Print
  attr_reader :products, :sale_tax, :price

  def initialize(results)
    @products = results[:products]
    @sale_tax = results[:sale_tax]
    @price = results[:price]
  end

  def print_bill
    print_product
    print_sale_tax
    print_price
  end

  def print_product
    @products.each do |item|
      puts "#{item[:quantity]}, #{item[:product]}, #{item[:price_with_tax]}"
    end
  end

  def print_sale_tax
    puts "Sales Taxes: #{@sale_tax}"
  end

  def print_price
    puts "Total: #{@price}"
  end
end
