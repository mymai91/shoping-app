require 'csv'
require 'byebug'
require_relative 'transform'
require_relative 'caculator'
require_relative 'print'

class Output
  def self.print_bill(file)
    products = Transform.new(file).csv

    result = Caculator.new(products).caculator

    Print.new(result).print_bill
  end
end

# Output.print_bill('db/order.csv')
