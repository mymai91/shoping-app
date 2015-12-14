require 'bigdecimal'
class Caculator
  RATE_GOOD_TAX = 0.1
  RATE_IMPORTED_TAX = 0.05
  NEAREST_CENT = 1 / 0.05

  attr_reader :products

  def initialize(products)
    @products = products
  end

  def caculator
    total_sale_tax = 0
    total_price = 0

    @result = {}
    @products.each_with_index do |item, index|
      quantity = item[:quantity]
      product = item[:product]
      price = item[:price]
      except = item[:except]
      imported = item[:imported]

      good_tax = good_tax(price, except)
      imported_tax = imported_tax(price, imported)
      good_price = good_price(quantity, price)
      sale_tax = sale_tax(quantity, good_tax, imported_tax)
      price_with_tax = price_with_tax(good_price, sale_tax)

      total_sale_tax += sale_tax
      total_price += price_with_tax

      @products[index][:price_with_tax] = price_with_tax
    end

    @result[:sale_tax] = total_sale_tax
    @result[:price] = total_price
    @result[:products] = @products

    @result
  end

  def price_with_tax(good_price, sale_tax)
    (good_price + sale_tax).round(2)
  end

  def good_price(quantity, price)
    quantity * price
  end

  def sale_tax(quantity, good_tax, imported_tax)
    round_up(quantity * (good_tax + imported_tax))
  end

  def good_tax(good_price, except)
    except ? 0 : (good_price * RATE_GOOD_TAX)
  end

  def imported_tax(good_price, imported)
    imported ? (good_price * RATE_IMPORTED_TAX) : 0
  end

  def round_up(sale_tax)
    (sale_tax * NEAREST_CENT).ceil / NEAREST_CENT
  end
end
