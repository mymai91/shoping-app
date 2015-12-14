require 'spec_helper'

describe 'Caculator' do
  let(:products) do
    [
      { quantity: 1, product: 'book', price: 12.49, except: true, imported: false },
      { quantity: 1, product: 'music cd', price: 14.99, except: false, imported: false },
      { quantity: 1, product: 'box of imported chocolates', price: 11.25, except: true, imported: true },
      { quantity: 1, product: 'imported bottle of perfume', price: 47.50, except: false, imported: true }
    ]
  end

  let(:except_good)        { products[0] }
  let(:normal_good)        { products[1] }
  let(:import_good)        { products[2] }
  let(:import_normal_good) { products[3] }

  before do
    @init = Caculator.new(products)
    @results = @init.caculator
    product_then_caculator = @results[:products]
    @except_good = product_then_caculator[0]
    @normal_good = product_then_caculator[1]
    @import_good = product_then_caculator[2]
    @import_normal_good = product_then_caculator[3]
  end

  describe '#caculator' do
    it 'results must be a hash' do
      expect(@results.is_a?(Hash)).to be true
    end

    it 'results include sale_tax' do
      expect(@results). to include(:sale_tax)
    end

    it 'results include price' do
      expect(@results). to include(:price)
    end

    it 'results include products' do
      expect(@results). to include(:products)
    end
  end

  describe '#good_tax' do
    context 'normal good' do
      it 'good tax is applicable at a rate of 10% on all goods' do
        good_tax = (normal_good[:price].to_f.round(2) * 0.1)
        caculator_good_tax = @init.good_tax(@normal_good[:price], @normal_good[:except])

        expect(good_tax == caculator_good_tax). to be true
      end
    end

    context 'except good' do
      it 'except tax is applicable at a rate of 0% on all goods' do
        good_tax = except_good[:price] * 0
        caculator_except_good = @init.good_tax(@except_good[:price], @except_good[:except])

        expect(good_tax == caculator_except_good). to be true
      end
    end
  end

  describe '#imported_tax' do
    context 'import good' do
      it 'import tax is applicable at a rate of 5% on all goods' do
        import_good_tax = (import_good[:price].to_f.round(2) * 0.05)
        caculator_import_good = @init.imported_tax(@import_good[:price], @import_good[:imported])

        expect(import_good_tax == caculator_import_good). to be true
      end
    end

    context 'local good' do
      it 'import tax is applicable at a rate of 0% on all goods' do
        local_good_tax = normal_good[:price] * 0
        caculator_normal_good = @init.imported_tax(@normal_good[:price], @normal_good[:imported])

        expect(local_good_tax == caculator_normal_good). to be true
      end
    end
  end

  describe '#good_price' do
    it 'price of product' do
      except_good_price = except_good[:price] * except_good[:quantity]
      normal_good_price = normal_good[:price] * normal_good[:quantity]
      import_good_price = import_good[:price] * import_good[:quantity]

      expect(except_good_price == @except_good[:price]). to be true
      expect(normal_good_price == @normal_good[:price]). to be true
      expect(import_good_price == @import_good[:price]). to be true
    end
  end

  describe '#price_with_tax' do
    it 'except good' do
      good_tax = @init.good_tax(except_good[:price], except_good[:except])
      imported_tax = @init.imported_tax(except_good[:price], except_good[:imported])
      sale_tax = @init.sale_tax(except_good[:quantity], good_tax, imported_tax)
      good_price = @init.good_price(except_good[:quantity], except_good[:price])
      price_with_tax = @init.price_with_tax(good_price, sale_tax)

      expect(price_with_tax == @except_good[:price_with_tax]). to be true
    end

    it 'normal good' do
      good_tax = @init.good_tax(normal_good[:price], normal_good[:except])
      imported_tax = @init.imported_tax(normal_good[:price], normal_good[:imported])
      sale_tax = @init.sale_tax(normal_good[:quantity], good_tax, imported_tax)
      good_price = @init.good_price(normal_good[:quantity], normal_good[:price])
      price_with_tax = @init.price_with_tax(good_price, sale_tax)

      expect(price_with_tax == @normal_good[:price_with_tax]). to be true
    end

    it 'import good' do
      good_tax = @init.good_tax(import_good[:price], import_good[:except])
      imported_tax = @init.imported_tax(import_good[:price], import_good[:imported])
      sale_tax = @init.sale_tax(import_good[:quantity], good_tax, imported_tax)
      good_price = @init.good_price(import_good[:quantity], import_good[:price])
      price_with_tax = @init.price_with_tax(good_price, sale_tax)

      expect(price_with_tax == @import_good[:price_with_tax]). to be true
    end

    it 'import normal good' do
      good_tax = @init.good_tax(import_normal_good[:price], import_normal_good[:except])
      imported_tax = @init.imported_tax(import_normal_good[:price], import_normal_good[:imported])
      sale_tax = @init.sale_tax(import_normal_good[:quantity], good_tax, imported_tax)
      good_price = @init.good_price(import_normal_good[:quantity], import_normal_good[:price])
      price_with_tax = @init.price_with_tax(good_price, sale_tax)

      expect(price_with_tax == @import_normal_good[:price_with_tax]). to be true
    end
  end
end
