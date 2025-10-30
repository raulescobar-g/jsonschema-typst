#import "../typst-package/lib.typ": validate

= Conditional Schema Validation

This example demonstrates conditional validation using if/then/else, anyOf, allOf, oneOf, and not.

== If/Then/Else

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"country\": { \"type\": \"string\" },
    \"postalCode\": { \"type\": \"string\" }
  },
  \"if\": {
    \"properties\": { \"country\": { \"const\": \"USA\" } }
  },
  \"then\": {
    \"properties\": {
      \"postalCode\": { \"pattern\": \"^[0-9]{5}$\" }
    }
  },
  \"else\": {
    \"properties\": {
      \"postalCode\": { \"pattern\": \"^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$\" }
    }
  }
}"

#let data = "{
  \"country\": \"USA\",
  \"postalCode\": \"12345\"
}"

#let result = validate(schema, data)

*Country:* #result.country

*Postal Code:* #result.postalCode

== anyOf (At Least One)

#let schema = "{
  \"anyOf\": [
    { \"type\": \"string\", \"maxLength\": 5 },
    { \"type\": \"number\", \"minimum\": 0 }
  ]
}"

#let data = "1"

#let result = validate(schema, data)

*Result:* #result

== allOf (All Must Match)

#let schema = "{
  \"allOf\": [
    { \"type\": \"number\" },
    { \"minimum\": 0 },
    { \"maximum\": 100 }
  ]
}"

#let data = "50"

#let result = validate(schema, data)

*Result:* #result

== oneOf (Exactly One)

#let schema = "{
  \"oneOf\": [
    { \"type\": \"number\", \"multipleOf\": 5 },
    { \"type\": \"number\", \"multipleOf\": 3 }
  ]
}"

#let data = "9"

#let result = validate(schema, data)

*Result:* #result

== not (Must Not Match)

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"name\": { \"type\": \"string\" }
  },
  \"not\": {
    \"properties\": {
      \"name\": { \"const\": \"admin\" }
    }
  }
}"

#let data = "{
  \"name\": \"user\"
}"

#let result = validate(schema, data)

*Name:* #result.name
