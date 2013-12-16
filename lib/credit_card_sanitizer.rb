require 'luhn_checksum'

class CreditCardSanitizer

  NUMBERS_WITH_LINE_NOISE = /(
    \d       # starts with a number
    [\d|\W]+ # number or non-word character
    \d       # ends with a number
   )/x

   def initialize(replacement_token)
     @replacement_token = replacement_token
   end

   def sanitize!(text)
     replaced = false

     text.gsub!(NUMBERS_WITH_LINE_NOISE) do |match|
       numbers = match.gsub(/\D/, '')

       if !too_short?(numbers) && LuhnChecksum.valid?(numbers)
         replaced = true
         replace_numbers!(match, numbers)
       end

       match
     end

     replaced ? text : nil
   end

   def too_short?(numbers)
     13 > numbers.size
   end

   def replace_numbers!(text, numbers)
     # Leave the last 4 numbers visible
     replacement_limit = numbers.size - 4
     replacement_count = 0

     text.gsub!(/\d/) do |number|
       if replacement_count < replacement_limit
         replacement_count += 1
         @replacement_token
       else
         number
       end
     end
   end
end
