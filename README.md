credit_card_sanitizer
=====================

Remove credit card numbers from user text.

```Ruby
a = "Hello my card is 12 345123 451234 8 maybe you should not store that in your database!"
CreditCardSanitizer.new('X').sanitizer.sanitize!(a)
a == "Hello my card is XX XXXXX XXX234 8 maybe you should not store that in your database!"
```

License: MIT<br/>
[![Build Status](https://travis-ci.org/eac/credit_card_sanitizer.png)](https://travis-ci.org/eac/credit_card_sanitizer)
