#import "../typst-package/lib.typ": validate

= Object Property Validation

This example demonstrates validation of objects with typed properties.

== Simple Object

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"name\": { \"type\": \"string\" },
    \"age\": { \"type\": \"number\" }
  },
  \"required\": [\"name\"]
}"

#let data = "{
  \"name\": \"Alice\",
  \"age\": 30
}"

#let result = validate(schema, data)

*Result:* #result

*Name:* #result.name

*Age:* #result.age

== Object with Additional Properties

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"id\": { \"type\": \"number\" }
  },
  \"additionalProperties\": false
}"

#let data = "{
  \"id\": 123
}"

#let result = validate(schema, data)

*Result:* #result

== Object with Pattern Properties

#let schema = "{
  \"type\": \"object\",
  \"patternProperties\": {
    \"^[0-9]+$\": { \"type\": \"string\" }
  }
}"

#let data = "{
  \"123\": \"one two three\",
  \"456\": \"four five six\"
}"

#let result = validate(schema, data)

*Result:* #result
