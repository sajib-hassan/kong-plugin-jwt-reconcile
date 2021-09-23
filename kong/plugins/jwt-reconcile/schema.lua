local typedefs = require "kong.db.schema.typedefs"

return {
  name = "jwt-reconcile",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
      type = "record",
      fields = {
        { method = { type = "string", default = "POST", one_of = { "POST", "GET", }, }, },
        { url = typedefs.url({ required = true }) },

        { path = { type = "string", default = "/api/v1/auth/reconcile", }, },

        { connect_timeout = { type = "number", default = 5000, }, },
        { send_timeout = { type = "number", default = 10000, }, },
        { read_timeout = {  type = "number", default = 10000, }, },

        { copy_headers = { type = "boolean", default = ture, }, },
        { forward_path = { type = "boolean", default = false, }, },
        { forward_query = { type = "boolean", default = false, }, },
        { forward_headers = { type = "boolean", default = false, }, },
        { forward_body = { type = "boolean", default = false, }, },

        { inject_body_response_into_header = { type = "boolean", default = true, }, },
        { injected_header_prefix = { type = "string", default = '', }, },
        { streamdown_injected_headers = { type = "boolean", default = false, }, },
      },
    }, },
  }
}
