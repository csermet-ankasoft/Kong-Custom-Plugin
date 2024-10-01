local typedefs = require "kong.db.schema.typedefs"

local PLUGIN_NAME = "accessRoute"

local schema = {
  name = PLUGIN_NAME,
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { request_header = typedefs.header_name {
              required = true,
              default = "Hello-World" } },
          { response_header = typedefs.header_name {
              required = true,
              default = "Bye-World" } },
          { ttl = {
              type = "integer",
              default = 600,
              required = true,
              gt = 0, }},
          { service_x_host = {
              type = "string",
              required = true,
              default = "nginx-deployment.nginx.svc.cluster.local" } },
          { service_x_port = {
              type = "integer",
              required = true,
              default = 80 }},
          { service_y_host = {
              type = "string",
              required = true,
              default = "google.com" } },
          { service_y_port = {
              type = "integer",
              required = true,
              default = 80 }},
        },
      },
    },
  },
}

return schema
