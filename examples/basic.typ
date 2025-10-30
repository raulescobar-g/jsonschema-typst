#import "../typst-package/lib.typ": validate

= Basic Type Validation

This example demonstrates simple type validation for different JSON types.

== String Validation

#let schema = "{
  \"type\": \"string\"
}"

#let data = "\"Hello, World!\""

#let result = validate(schema, data)

*Result:* #result

== Number Validation

#let schema = "{
  \"type\": \"number\"
}"

#let data = "42"

#let result = validate(schema, data)

*Result:* #result

== Boolean Validation

#let schema = "{
  \"type\": \"boolean\"
}"

#let data = "true"

#let result = validate(schema, data)

*Result:* #result

== Null Validation

#let schema = "{
  \"type\": \"null\"
}"

#let data = "null"

#let result = validate(schema, data)

*Result:* #result
