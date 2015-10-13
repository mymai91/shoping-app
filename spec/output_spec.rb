require_relative '../output.rb'
require 'byebug'

describe Output do
  before do
    items =  [
                {quantity: 1, product: "book", price: 12.49},
                {quantity: 1, product: "music cd", price: 14.99},
                {quantity: 1, product: "chocolate bar", price: 0.85}
              ]
    @output = Output.new(items)
  end

  describe '#total_price' do
    it 'total price' do
      total_price = @output.total_price
      expect(total_price).to eq(29.83)
    end
  end

  describe '#total_sales_tax' do
    it 'total sales' do
      total_sales = @output.total_sales_tax
      expect(total_sales).to eq(1.50)
    end
  end
end
