require 'byebug'
require 'csv'
require_relative 'transform'
require_relative 'caculator'
require_relative 'print'

products = Transform.new('db/order.csv').csv

result = Caculator.new(products).caculator

Print.new(result).print_bill
