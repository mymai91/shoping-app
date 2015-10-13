require_relative 'tax'

class Item
  attr_reader :quantity, :product, :price

  def initialize(quantity, product, price)
    @quantity = quantity
    @product = product
    @price = price
  end

  def amount_with_taxes
    quantity? && price? ? (amount_without_taxes + taxes).round(2) : nil
  end

  # Check quantity is a number and greater than 0
  def quantity?
    if (quantity.is_a? Numeric) && quantity > 0
      if quantity.to_f - quantity.to_i == 0
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def price?
    (price.is_a? Numeric) && price > 0
  end

  def amount_without_taxes
    quantity? && price? ? quantity * price : nil
  end

  def taxes
    tax = Tax.new(product, price)
    quantity? && price? ? ((quantity * tax.caculator) * 20).round.to_f / 20 : nil
  end

  def print_item
    "#{quantity}, #{product}, #{'%.2f' % amount_with_taxes}" if quantity? && price?
  end
end
