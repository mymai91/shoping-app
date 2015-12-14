require 'spec_helper'

describe Transform do
  before do
    EXCEPT_GOODS = ['book', 'chocolate', 'pill', 'books', 'chocolates', 'pills']
    IMPORT_GOODS = ['imported']
  end

  describe '#except_value?' do
    it 'it is a except goods' do
      book_arr = %w(Elf on the Book)
      value = book_arr + EXCEPT_GOODS
      expect(except_value?(value)).to be true
    end

    it 'it is not except goods' do
      cd_arr = %w(cd music)
      value = cd_arr + EXCEPT_GOODS
      expect(except_value?(value)).to be false
    end
  end

  describe '#imported_value?' do
  end

  describe '#csv' do
  end
end
