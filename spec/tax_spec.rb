require_relative '../tax.rb'

describe Tax do

  describe 'taxes caculator' do
    it 'sales product' do
      sales_tax = Tax.new("music cd", 14.99).caculator

      expect(sales_tax).to eq(1.499)
    end

    it 'except product' do
      except_tax_book = Tax.new("story book", 12.49).caculator
      except_tax_food = Tax.new("chocolate bar", 0.85).caculator
      except_tax_pill = Tax.new("packet of headache pills", 9.75).caculator

      expect(except_tax_book).to eq 0
      expect(except_tax_food).to eq 0
      expect(except_tax_pill).to eq 0
    end

    it 'expect product also imported product' do
      except_imported_tax = Tax.new("imported box of chocolates", 10.00).caculator

      expect(except_imported_tax).to equal 0.5
    end

    it 'sales product also imported product' do
      sale_imported_tax = Tax.new("imported bottle of perfume", 40.0).caculator

      expect(sale_imported_tax).to equal 6.0
    end

  end
end
