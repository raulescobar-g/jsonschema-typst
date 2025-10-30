#import "../typst-package/lib.typ": validate

= String Constraint Validation

This example demonstrates various constraints for string validation.

== Length Constraints

#let schema = "{
  \"type\": \"string\",
  \"minLength\": 3,
  \"maxLength\": 10
}"

#let data = "\"hello\""

#let result = validate(schema, data)

*Result:* #result

*Length:* #result.len()

== Pattern Matching (Regex)

#let schema = "{
  \"type\": \"string\",
  \"pattern\": \"^[A-Z][a-z]+$\"
}"

#let data = "\"Alice\""

#let result = validate(schema, data)

*Result:* #result

== Email Format

#let schema = "{
  \"type\": \"string\",
  \"format\": \"email\"
}"

#let data = "\"alice@example.com\""

#let result = validate(schema, data)

*Result:* #result

== URI Format

#let schema = "{
  \"type\": \"string\",
  \"format\": \"uri\"
}"

#let data = "\"https://example.com/path\""

#let result = validate(schema, data)

*Result:* #result

== Date-Time Format

#let schema = "{
  \"type\": \"string\",
  \"format\": \"date-time\"
}"

#let data = "\"2025-10-30T12:00:00Z\""

#let result = validate(schema, data)

*Result:* #result

== UUID Format

#let schema = "{
  \"type\": \"string\",
  \"format\": \"uuid\"
}"

#let data = "\"550e8400-e29b-41d4-a716-446655440000\""

#let result = validate(schema, data)

*Result:* #result
