JSCK = require("jsck").draft4

Description = require "./description"

module.exports = class API

  constructor: ({@schema, @resources, @mappings}) ->

  validate: ->
    errors = []

    try
      # JSCK throws if given an invalid schema.
      @schema_validator = new JSCK(@schema)
    catch error
      errors.push
        type: "Invalid schema"
        reason: error.message

    for error in Description.resources.validate(@resources).errors
      errors.push
        type: "API resources format"
        schema: error.schema
        document: error.document

    for error in Description.mappings.validate(@mappings).errors
      errors.push
        type: "API mappings format"
        schema: error.schema
        document: error.document

    if errors.length != 0
      # If the API description format is invalid, bail out early, as there
      # is no point in checking the description's internal references.
      return { valid: false, errors: errors }
    

    output = {valid: true, errors: []}
    report = @validate_resources()
    if report.valid == false
      output.valid = false
      output.errors = output.errors.concat(report.errors)

    report = @validate_mappings()
    if report.valid == false
      output.valid = false
      output.errors = output.errors.concat(report.errors)

    return output

  validate_mappings: ->
    # TODO: report resources for which there are no mappings
    report =
      valid: true
      errors: []

    for name, definition of @mappings
      {path} = definition

      resource_name = definition.resource || name
      if !@resources[resource_name]?
        report.valid = false
        report.errors.push
          type: "Mapping reference"
          location: "mappings.#{name}"
          reason: "No such resource: '#{resource_name}'"

    return report


  validate_resources: ->
    report =
      valid: true
      errors: []

    for resource_name, {actions} of @resources
      for action_name, {request, response} of actions
        if (type = request?.type)?
          for mt in type
            if !@schema_validator.media_types[mt]?
              report.valid = false
              report.errors.push
                type: "Action definition"
                location: "resources.#{resource_name}.actions.#{action_name}"
                mt: mt
                reason: """
                  Action specifies a request.type that is not defined in the schema.
              """
        if (type = response?.type)?
          for mt in type
            if !@schema_validator.media_types[mt]?
              report.valid = false
              report.errors.push
                type: "Action definition"
                location: "resources.#{resource_name}.actions.#{action_name}"
                mt: mt
                reason: """
                  Action specifies a response.type that is not defined in the schema.
              """

    return report







