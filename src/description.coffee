JSCK = require("jsck/src").draft4

exports.schemas = [
  require("./description/resources"),
  require("./description/mappings"),
]

exports.jsck = new JSCK(exports.schemas...)
exports.resources = exports.jsck.validator("urn:patchboard.api.resources#")
exports.mappings = exports.jsck.validator("urn:patchboard.api.mappings#")

