local cjson = require "cjson"
local storage = require "storage"
local dispatcher = require "dispatcher"

local pg = storage.connect_db()
assert(pg:connect())

function get_goods()
	local res, message = storage.list_goods(pg)
	if not res then
		ngx.exit(404) -- treat all errors as NOT_FOUND
	else
		ngx.say(cjson.encode(res))
	end
end

function get_single_good(matches)
	ngx.log(ngx.ERR, "retrieving good: "..matches[1])
end

function add_good()
	ngx.log(ngx.ERR, "adding good")
end

dispatcher.addrule("GET","/(.+)$",get_single_good)
dispatcher.addrule("GET","/?$",get_goods)
dispatcher.addrule("POST","/$",add_good)
dispatcher.dispatch("^/api/goods")

return




--[[
local pg = storage.connect_db()
assert(pg:connect())

if (ngx.var.request_method == "POST") then
	ngx.log(ngx.ERR,"POST /api/goods not implemented yet!")
	ngx.exit(404)
elseif (ngx.var.request_method == "GET" and not ngx.var.goodid) then
	local res, message = storage.list_goods(pg)
	if not res then
		ngx.exit(404) -- treat all errors as NOT_FOUND
	else
		ngx.say(cjson.encode(res))
	end
elseif (ngx.var.request_method == "GET" and ngx.var.goodid) then
	ngx.log(ngx.ERR,"POST /api/goods/{goodid} not implemented yet!")
	ngx.exit(404)
end

]]--
