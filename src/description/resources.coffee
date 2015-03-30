module.exports =
  id: "urn:patchboard.api.resources#"

  description: "A dictionary of resource descriptions"
  type: "object"
  additionalProperties: {$ref: "#/definitions/resource"}


  # JSON Schema convention is to keep non-root schema definitions in
  # the #/definitions dictionary.
  definitions:

    resource:
      description: """
        Describes an API resource. Name is inferred from the property key
      """

      additionalProperties: false
      required: [ "actions" ]
      properties:
        title:
          type: "string"
        description:
          type: "string"
        actions:
          type: "object"
          description: "A dictionary of actions"
          additionalProperties: {$ref: "#/definitions/action"}

    action:
      type: "object"
      description: """
        Describes an action for a resource. Name is inferred from the property key.
      """

      additionalProperties: false
      required: [ "request", "response" ]
      properties:
        title:
          type: "string"
        description:
          type: "string"

        request:
          type: "object"
          additionalProperties: false
          required: [ "method" ]
          properties:
            method:
              title: "The HTTP method used for this action"
              type: "string"
              enum: ["GET", "PUT", "POST", "PATCH", "DELETE"]
            authorization:
              title: "The names of the supported authorization schemes"
              type: ["string", "array", "boolean"]
            type:
              title: "The media types supported for request content"
              type: "array"
              items:
                type: "string"
            multipart:
              title: "The media types for the parts of a multipart/form body"
              type: "array"
              items:
                type: "string"

        response:
          type: "object"
          required: [ "status" ]
          properties:
            status:
              title: "HTTP status codes that indicate success"
              type: "array"
              items:
                type: "integer"
                enum: [200, 201, 202, 204]
            type:
              title: "The media types available for response content"
              type: "array"
              items:
                type: "string"



