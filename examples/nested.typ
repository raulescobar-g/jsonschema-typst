#import "../typst-package/lib.typ": validate

= Nested Object Validation

This example demonstrates validation of nested and complex object structures.

== Simple Nested Object

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"name\": { \"type\": \"string\" },
    \"address\": {
      \"type\": \"object\",
      \"properties\": {
        \"street\": { \"type\": \"string\" },
        \"city\": { \"type\": \"string\" },
        \"zipcode\": { \"type\": \"string\" }
      },
      \"required\": [\"city\"]
    }
  }
}"

#let data = "{
  \"name\": \"Alice\",
  \"address\": {
    \"street\": \"123 Main St\",
    \"city\": \"Springfield\",
    \"zipcode\": \"12345\"
  }
}"

#let result = validate(schema, data)

*Name:* #result.name

*City:* #result.address.city

*Street:* #result.address.street

== Array of Objects

#let schema = "{
  \"type\": \"array\",
  \"items\": {
    \"type\": \"object\",
    \"properties\": {
      \"id\": { \"type\": \"number\" },
      \"name\": { \"type\": \"string\" }
    },
    \"required\": [\"id\", \"name\"]
  }
}"

#let data = "[
  { \"id\": 1, \"name\": \"Alice\" },
  { \"id\": 2, \"name\": \"Bob\" },
  { \"id\": 3, \"name\": \"Charlie\" }
]"

#let result = validate(schema, data)

*Count:* #result.len()

*First person:* #result.at(0).name

*Second person:* #result.at(1).name

== Deeply Nested Structure

#let schema = "{
  \"type\": \"object\",
  \"properties\": {
    \"company\": {
      \"type\": \"object\",
      \"properties\": {
        \"name\": { \"type\": \"string\" },
        \"departments\": {
          \"type\": \"array\",
          \"items\": {
            \"type\": \"object\",
            \"properties\": {
              \"name\": { \"type\": \"string\" },
              \"employees\": {
                \"type\": \"array\",
                \"items\": {
                  \"type\": \"object\",
                  \"properties\": {
                    \"name\": { \"type\": \"string\" },
                    \"role\": { \"type\": \"string\" }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}"

#let data = "{
  \"company\": {
    \"name\": \"TechCorp\",
    \"departments\": [
      {
        \"name\": \"Engineering\",
        \"employees\": [
          { \"name\": \"Alice\", \"role\": \"Developer\" },
          { \"name\": \"Bob\", \"role\": \"Manager\" }
        ]
      }
    ]
  }
}"

#let result = validate(schema, data)

*Company:* #result.company.name

*Department:* #result.company.departments.at(0).name

*First employee:* #result.company.departments.at(0).employees.at(0).name
