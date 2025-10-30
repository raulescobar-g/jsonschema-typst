#import "../typst-package/lib.typ": validate

= Enum Validation

This example demonstrates enum validation for restricting values to a specific set.

== String Enum

#let schema = "{
  \"type\": \"string\",
  \"enum\": [\"red\", \"green\", \"blue\"]
}"

#let data = "\"green\""

#let result = validate(schema, data)

*Result:* #result

== Number Enum

#let schema = "{
  \"type\": \"number\",
  \"enum\": [1, 2, 3, 5, 8, 13]
}"

#let data = "5"

#let result = validate(schema, data)

*Result:* #result

== Mixed Type Enum

#let schema = "{
  \"enum\": [\"draft\", \"published\", 1, 2, true, null]
}"

#let data = "\"published\""

#let result = validate(schema, data)

*Result:* #result

== Object with Enum Property

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"status\": {
      \"type\": \"string\",
      \"enum\": [\"pending\", \"approved\", \"rejected\"]
    },
    \"priority\": {
      \"type\": \"number\",
      \"enum\": [1, 2, 3]
    }
  }
}"

#let data = "{
  \"status\": \"approved\",
  \"priority\": 2
}"

#let result = validate(schema, data)

*Result:* #result

*Status:* #result.status

*Priority:* #result.priority
