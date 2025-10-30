#import "../typst-package/lib.typ": validate

= Error Handling

This example demonstrates how validation errors are reported when data doesn't match the schema.

== Valid Data

First, let's validate some correct data:

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"name\": { \"type\": \"string\" },
    \"age\": { \"type\": \"number\", \"minimum\": 0 }
  },
  \"required\": [\"name\"]
}"

#let data = "{
  \"name\": \"Alice\",
  \"age\": 30
}"

#let result = validate(schema, data)

*Valid Result:* #result

== Type Mismatch Example

The following would fail with a type error if uncommented:

```typst
#let schema = "{\"type\": \"number\"}"
#let data = "\"not a number\""
#let result = validate(schema, data)
```

This would produce an error like:
```
Validation failed
  at /: "not a number" is not of type "number"
```

== Missing Required Property

The following would fail due to a missing required field:

```typst
#let schema = "{\"type\": \"object\", \"properties\": {\"name\": {\"type\": \"string\"}}, \"required\": [\"name\"]}"
#let data = "{}"
#let result = validate(schema, data)
```

This would produce an error indicating the required "name" property is missing.

== Constraint Violation

The following would fail due to a constraint violation:

```typst
#let schema = "{\"type\": \"number\", \"minimum\": 0, \"maximum\": 100}"
#let data = "150"
#let result = validate(schema, data)
```

This would produce an error indicating the value exceeds the maximum.

== Pattern Mismatch

The following would fail due to pattern mismatch:

```typst
#let schema = "{\"type\": \"string\", \"pattern\": \"^[A-Z]\"}"
#let data = "\"lowercase\""
#let result = validate(schema, data)
```

This would produce an error indicating the string doesn't match the required pattern.

*Note:* The examples above are commented out to prevent actual validation errors. 
To see these errors in action, uncomment the code blocks and compile the document.
