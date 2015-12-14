require 'bigdecimal'

class Caculator

  RATE_GOOD_TAX = 0.1
  RATE_IMPORTED_TAX = 0.05
  NEAREST_CENT = 0.05

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
      expect = item[:expect]
      imported = item[:imported]

      good_tax = good_tax(price, expect)
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

    return @result
  end

  def price_with_tax(good_price, sale_tax)
    good_price + sale_tax
  end

  def good_price(quantity, price)
    quantity * price
  end

  def sale_tax(quantity, good_tax, imported_tax)
    quantity * (good_tax + imported_tax)
    # tax = quantity * (good_tax + imported_tax)
    # byebug
    # round_up(tax)
  end

  def good_tax(good_price, expect)
    expect ? 0 : (good_price * RATE_GOOD_TAX)
  end

  def imported_tax(good_price, imported)
    imported ? (good_price * RATE_IMPORTED_TAX) : 0
  end

  def round_up(sale_tax)
    (sale_tax * NEAREST_CENT).ceil / NEAREST_CENT
  end

end
