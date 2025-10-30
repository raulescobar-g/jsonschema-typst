#import "../typst-package/lib.typ": validate

= Array Validation

This example demonstrates array validation with various constraints.

== Simple Array

#let schema = "{
  \"type\": \"array\",
  \"items\": { \"type\": \"number\" }
}"

#let data = "[1, 2, 3, 4, 5]"

#let result = validate(schema, data)

*Result:* #result

== Array with Length Constraints

#let schema = "{
  \"type\": \"array\",
  \"items\": { \"type\": \"string\" },
  \"minItems\": 2,
  \"maxItems\": 5
}"

#let data = "[\"apple\", \"banana\", \"cherry\"]"

#let result = validate(schema, data)

*Result:* #result

*Length:* #result.len()

== Array with Unique Items

#let schema = "{
  \"type\": \"array\",
  \"items\": { \"type\": \"number\" },
  \"uniqueItems\": true
}"

#let data = "[1, 2, 3, 4, 5]"

#let result = validate(schema, data)

*Result:* #result

== Tuple Validation (Prefix Items)

#let schema = "{
  \"type\": \"array\",
  \"prefixItems\": [
    { \"type\": \"string\" },
    { \"type\": \"number\" },
    { \"type\": \"boolean\" }
  ]
}"

#let data = "[\"hello\", 42, true]"

#let result = validate(schema, data)

*Result:* #result

*First:* #result.at(0)

*Second:* #result.at(1)

*Third:* #result.at(2)
