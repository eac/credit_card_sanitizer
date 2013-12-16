require_relative 'helper'

class CreditCardSanitizerTest < MiniTest::Test

  describe "Credit card sanitizer" do
    before do
      @sanitizer = CreditCardSanitizer.new('X')
    end

    it "sanitizes text" do
      assert_equal 'Hello XX XXXXXX XXX234 8 there',     @sanitizer.sanitize!('Hello 12 345123 451234 8 there')
      assert_equal 'Hello XX XXXXXX XXX234 8 z 3 there', @sanitizer.sanitize!('Hello 12 345123 451234 8 z 3 there')
    end

    it "has configurable replacement characters" do
      sanitizer = CreditCardSanitizer.new('*')
      assert_equal 'Hello ** ****** ***234 8 there', sanitizer.sanitize!('Hello 12 345123 451234 8 there')
    end

    it "does not sanitize invalid credit card numbers" do
      invalid_luhn = 'Hello 12 345123 451234 81 there'
      assert_equal nil, @sanitizer.sanitize!(invalid_luhn)
      assert_equal 'Hello 12 345123 451234 81 there', invalid_luhn

      too_short = 'Hello 49 9273 987 16 there'
      assert_equal nil, @sanitizer.sanitize!(too_short)
    end

  end
end
