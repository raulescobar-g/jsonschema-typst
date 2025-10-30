#import "../typst-package/lib.typ": validate

= Number Constraint Validation

This example demonstrates various constraints for number validation.

== Minimum and Maximum

#let schema = "{
  \"type\": \"number\",
  \"minimum\": 0,
  \"maximum\": 100
}"

#let data = "42"

#let result = validate(schema, data)

*Result:* #result

== Exclusive Minimum and Maximum

#let schema = "{
  \"type\": \"number\",
  \"exclusiveMinimum\": 0,
  \"exclusiveMaximum\": 100
}"

#let data = "50"

#let result = validate(schema, data)

*Result:* #result

== Multiple Of

#let schema = "{
  \"type\": \"number\",
  \"multipleOf\": 5
}"

#let data = "25"

#let result = validate(schema, data)

*Result:* #result

== Integer Type

#let schema = "{
  \"type\": \"integer\"
}"

#let data = "42"

#let result = validate(schema, data)

*Result:* #result

== Combined Constraints

#let schema = "{
  \"type\": \"number\",
  \"minimum\": 0,
  \"maximum\": 1000,
  \"multipleOf\": 10
}"

#let data = "250"

#let result = validate(schema, data)

*Result:* #result
