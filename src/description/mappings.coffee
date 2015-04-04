module.exports =
  id: "urn:patchboard.api.endpoints#"

  description: "A dictionary of resource descriptions"
  type: "object"
  additionalProperties: {$ref: "#/definitions/endpoint"}


  # JSON Schema convention is to keep non-root schema definitions in
  # the #/definitions dictionary.
  definitions:

    endpoint:
      type: "object"
      additionalProperties: false
      required: [ "path", "mappings" ]
      properties:
        description:
          type: "string"
        path:
          description: """
            The URL path that maps to the resource.  May use RFC 6570-like URI
            templating to indicate parameter interpolation.
          """
          type: "string"
        mappings:
          type: "array"
          minItems: 1
          items:
            type: "object"
            required: [ "resource", "query" ]
            properties:
              resource:
                description: """
                  The name of the API resource
                """
                type: "string"
              query:
                type: ["object", "boolean" ]
                properties:
                  type:
                    enum:
                      ["string", "number", "integer", "boolean", "enum"]

