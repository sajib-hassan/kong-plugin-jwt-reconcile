local access = require "kong.plugins.jwt-reconcile.access"
local JwtReconcileHandler = {}

JwtReconcileHandler.PRIORITY = 900
JwtReconcileHandler.VERSION = "1.0.0"

function JwtReconcileHandler:access(conf)
  access.execute(conf, JwtReconcileHandler.VERSION)
end

return JwtReconcileHandler
