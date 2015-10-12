local pgmoon = require "pgmoon"
local cjson = require "cjson"


local pg = pgmoon.new({
  host = "127.0.0.1",
  port = "5432",
  database = "dxm",
  user = "nando",
  password = "nando"
})

function list_users()
	local res = assert(pg:query("select * from users"))
	return res
end

assert(pg:connect())

if (ngx.var.request_method == "GET") then
	ngx.say(cjson.encode(list_users()))
elseif (ngx.var.request_method == "POST") then
	ngx.say("received POST")
end


