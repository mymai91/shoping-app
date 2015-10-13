class Tax
  attr_reader :product, :price

  def initialize(product, price)
    @product = product
    @price = price
  end

  def caculator
    case
    when except_product? && !import_product?
      except_taxes
    when except_product? && import_product?
      import_taxes
    when !except_product? && import_product?
      sale_taxes + import_taxes
    else
      sale_taxes
    end
  end

  def sale_taxes
    price * 0.1
  end

  def import_taxes
    price * 0.05
  end

  def except_taxes
    price * 0
  end

  def except_product?
    product_arr = product.split(' ')

    except_product_arr = ['chocolate', 'chocolates', 'book', 'books', 'pill', 'pills']
    (except_product_arr - product_arr).count != except_product_arr.count
  end

  def import_product?
    product_arr = product.split(' ')

    product_arr.include?('imported')
  end
end
