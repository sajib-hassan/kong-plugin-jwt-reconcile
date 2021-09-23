local plugin_name = "jwt-reconcile"
local package_name = "kong-plugin-" .. plugin_name
local package_version = "0.1.0"
local rockspec_revision = "1"

local git_checkout = package_version == "dev" and "master" or package_version

package = package_name
version = package_version .. "-" .. rockspec_revision
supported_platforms = { "linux", "macosx" }
source = {
  url = "git@github.com/sajib-hassan/kong-plugin-jwt-reconcile",
  branch = git_checkout,
}

description = {
  summary = "A Kong plugin that enables an extra HTTP POST/GET request - jwt-reconcile-request - before proxying to the original request.",
  homepage = "git@github.com/sajib-hassan/kong-plugin-jwt-reconcile",
  license = "Apache 2.0",
}

dependencies = {
  "lua >= 5.1",
  "lua-cjson >= 2.1",
  "lua-resty-http >= 0.11",
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins."..plugin_name..".access"] = "kong/plugins/"..plugin_name.."/access.lua",
    ["kong.plugins."..plugin_name..".handler"] = "kong/plugins/"..plugin_name.."/handler.lua",
    ["kong.plugins."..plugin_name..".schema"] = "kong/plugins/"..plugin_name.."/schema.lua",
  }
}
