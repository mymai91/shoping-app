class Transform
  EXCEPT_GOODS = %w(book chocolate pill books chocolates pills)
  IMPORT_GOODS = ['imported']

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def csv
    @orders ||= []
    CSV.foreach(@file, headers: true) do |row|
      quantity = row[0].strip.to_i
      price = row[2].strip.to_f
      product_val = row[1].strip

      if quantity > 0 && price > 0
        item = {}

        product_arr = product_val.split(' ')
        except_value = (EXCEPT_GOODS + product_arr)
        imported_value = (IMPORT_GOODS + product_arr)

        item[:quantity] = quantity
        item[:product] = product_val
        item[:price] = price
        item[:except] = except_value?(except_value)
        item[:imported] = imported_value?(imported_value)
        @orders << item
      end
    end

    @orders
  end

  def except_value?(value)
    value.map!(&:downcase)
    value.uniq.length != value.length
  end

  def imported_value?(value)
    value.map!(&:downcase)
    value.uniq.length != value.length
  end
end
