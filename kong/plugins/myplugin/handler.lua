local plugin = {
  PRIORITY = 1000,
  VERSION = "0.2",
}

function plugin:init_worker()
  kong.log.debug("saying hi from the 'init_worker' handler")
end

function plugin:access(plugin_conf)
  local headers = kong.request.get_headers()
  local id_header = headers["id"]

  -- Eğer ID "5" ise X servisine yönlendir
  if id_header and id_header == "5" then
    -- X servisine yönlendir
    kong.service.set_target(plugin_conf.service_x_host, plugin_conf.service_x_port)
  else
    -- Y servisine yönlendir
    kong.service.set_target(plugin_conf.service_y_host, plugin_conf.service_y_port)
  end
end

function plugin:header_filter(plugin_conf)
  kong.response.set_header(plugin_conf.response_header, "this is on the response")
end

return plugin
