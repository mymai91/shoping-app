class Transform
  EXPECT_GOODS = ['book', 'chocolate', 'pill', 'books', 'chocolates', 'pills']
  IMPORT_GOODS = ['imported']

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def csv
    @orders ||= []

    # Check condition if quantity < 0, price < 0 ==> kick
    CSV.foreach(@file, headers: true) do |row|
      item = {}
      item[:quantity] = row[0].strip.to_i
      item[:product] = row[1].strip
      item[:price] = row[2].strip.to_f

      products = row[1].split(' ')

      expect_value = (EXPECT_GOODS + products)
      imported_value = (IMPORT_GOODS + products)

      item[:expect] = expect_value?(expect_value)
      item[:imported] = imported_value?(imported_value)
      @orders << item

    end

    return @orders

  end

  def expect_value?(value)
    value.uniq.length != value.length
  end

  def imported_value?(value)
    value.uniq.length != value.length
  end

end
