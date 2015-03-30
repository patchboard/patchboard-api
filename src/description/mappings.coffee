module.exports =
  id: "urn:patchboard.api.mappings#"

  description: "A dictionary of resource descriptions"
  type: "object"
  additionalProperties: {$ref: "#/definitions/mapping"}


  # JSON Schema convention is to keep non-root schema definitions in
  # the #/definitions dictionary.
  definitions:

    mapping:
      type: "object"
      additionalProperties: false
      properties:
        description:
          type: "string"
        resource:
          description: """
            The name of the API resource.  Defaults to the name of the mapping.
          """
          type: "string"
        path:
          description: """
            The URL path that maps to the resource.  May use RFC 6570-like URI
            templating to indicate parameter interpolation.
          """
          type: "string"
        query:
          type: "object"
          properties:
            type:
              enum:
                ["string", "number", "integer", "boolean", "enum"]

