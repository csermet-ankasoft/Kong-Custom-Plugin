local plugin = {
  PRIORITY = 1000,
  VERSION = "0.2",
}

function plugin:access(plugin_conf)
  kong.log.inspect(plugin_conf)
  local headers = kong.request.get_headers()
  local id_header = headers["id"]

  if id_header and id_header == "5" then
    kong.service.set_target(plugin_conf.service_x_host, plugin_conf.service_x_port)
  else
    kong.service.set_target(plugin_conf.service_y_host, plugin_conf.service_y_port)
  end
  kong.service.request.set_header(plugin_conf.request_header, "this is on a request")
end

function plugin:header_filter(plugin_conf)
  kong.response.set_header(plugin_conf.response_header, "response Test")
end

return plugin