local plugin = {
  PRIORITY = 1000,
  VERSION = "0.2",
}

function plugin:access(plugin_conf)
  kong.log.inspect(plugin_conf)

  local headers = kong.request.get_headers()
  local id_header = headers["id"]

  if id_header and id_header == "5" then
    kong.service.set_target(plugin_conf.redirect_service_host, plugin_conf.redirect_service_port)
  end
  
  kong.service.request.set_header(plugin_conf.request_header, "request Test")
end

function plugin:header_filter(plugin_conf)
  kong.response.set_header(plugin_conf.response_header, "response Test")
end

return plugin