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
          { redirect_service_host = {
              type = "string",
              required = true,
              default = "nginx-deployment.nginx.svc.cluster.local" } },
          { redirect_service_port = {
              type = "integer",
              required = true,
              default = 80 }},
        },
      },
    },
  },
}

return schema