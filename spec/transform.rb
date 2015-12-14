require 'spec_helper'

describe Transform do
  before do
    file_path = 'spec/fixtures/order.csv'
    @products = Transform.new(file_path).csv

    ###
    # @products is array
    # [
    #  {:quantity=>1, :product=>"book", :price=>12.49, :except=>true, :imported=>false}
    #  {:quantity=>1, :product=>"music cd", :price=>14.99, :except=>false, :imported=>false}
    #  {:quantity=>1, :product=>"box of imported chocolates", :price=>11.25, :except=>true, :imported=>true}
    # ]
  end

  describe '#except_value?' do
    it 'it is a except goods' do
      except_product = @products[0]

      expect(except_product[:except]).to be true
    end

    it 'it is not except goods' do
      normal_product = @products[1]

      expect(normal_product[:except]).to be false
    end
  end

  describe '#imported_value?' do
    it 'it is a import goods' do
      import_product = @products[2]

      expect(import_product[:imported]).to be true
    end

    it 'it is not import goods' do
      local_product = @products[1]

      expect(local_product[:imported]).to be false
    end
  end

  describe '#csv' do
    it 'csv will transform to list products' do
      expect(@products.is_a?(Array)).to be true
    end
  end
end
