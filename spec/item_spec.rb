require_relative '../item.rb'

describe Item do
  describe '#quantity?' do
    it 'quantity is valid' do
      valid_item = Item.new(1, "book", 12.49).quantity?
      expect(valid_item).to be true
    end

    it 'quantity is not valid' do
      float_quantity = Item.new(1.3, "candy", 12.49).quantity?
      minus_quantity = Item.new(-1, "candy", 12.49).quantity?
      string_quantity = Item.new("1", "candy", 12.49).quantity?

      expect(float_quantity).to be false
      expect(minus_quantity).to be false
      expect(string_quantity).to be false
    end
  end

  describe '#price' do
    it 'price is valid' do
      valid_item = Item.new(1, "book", 12.49).price?
      expect(valid_item).to be true
    end

    it 'price is not valid' do
      minus_price = Item.new(1, "candy", -12.49).price?
      string_price = Item.new(1, "candy", "12.49").price?

      expect(minus_price).to be false
      expect(minus_price).to be false
    end
  end

  describe '#amount_without_taxes' do
    describe 'quantity and price is valid' do
      it 'return price' do
        amount = Item.new(1, "book", 12.49).amount_without_taxes
        expect(amount).to eq(12.49)
      end
    end

    describe 'quantity and price is not valid' do
      it 'return nil' do
        amount = Item.new(1, "book", -12.49).amount_without_taxes
        expect(amount).to be_nil
      end
    end
  end

  describe '#taxes' do
    describe 'price is valid' do
      it 'return tax' do
        tax = Item.new(1, "book", 12.49).taxes
        expect(tax).to eq(0)
      end
    end

    describe 'price is not valid' do
      it 'return nil' do
        tax = Item.new(1, "book", -12.49).taxes
        expect(tax).to be_nil
      end
    end
  end

  describe '#amount_with_taxes' do
    describe 'quantity and price is valid' do
      it 'return price' do
        price_singular_item = Item.new(1, "bottle", 12.49).amount_with_taxes
        price_plural_item = Item.new(2, "bottle", 12.49).amount_with_taxes

        expect(price_singular_item).to eq(13.74)
        expect(price_plural_item).to eq(27.48)
      end
    end

    describe 'quantity and price is not valid' do
      it 'return nil' do
        invalid_price_item = Item.new(1, "book", -12.49).amount_with_taxes
        invalid_quantity_item = Item.new(-1, "book", 12.49).amount_with_taxes
        invalid_item = Item.new(-1, "book", -12.49).amount_with_taxes

        expect(invalid_price_item).to be_nil
        expect(invalid_quantity_item).to be_nil
        expect(invalid_item).to be_nil
      end
    end
  end

  describe '#print_item' do
    describe 'price is valid' do
      it 'quantity is 1' do
        output_content = Item.new(1, "bottle", 12.49).print_item

        expect(output_content).to include("1, bottle, 13.74")
      end

      it 'quantity more than 1' do
        output_content = Item.new(2, "bottle", 12.49).print_item

        expect(output_content).to include("2, bottle, 27.48")
      end
    end
  end
end
