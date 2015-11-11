local cjson = require "cjson"
local storage = require "storage"

--ngx.log(ngx.ERR, "host: "..ngx.var.host)
--ngx.log(ngx.ERR, "uri: "..ngx.var.uri)
-- ngx.log(ngx.ERR, "vars: "..ngx.var)

local m = ngx.re.match(ngx.var.uri, "^/api/goods(/.+)")
--ngx.log(ngx.ERR, "m[0]: "..m[0])
--ngx.log(ngx.ERR, "m[1]: "..m[1])


function get_goods()
	ngx.log(ngx.ERR, "retrieving goods")
end

function get_single_good()
	ngx.log(ngx.ERR, "retrieving a single good")
end

function add_good()
	ngx.log(ngx.ERR, "adding good")
end

function dispatch_request(base,rules)
	ngx.log(ngx.ERR,"dispatching request")
	print("asfasd")
	local req_method = ngx.req.get_method()
	for i,rule in ipairs(rules) do
		if req_method == rule.method then
			m = ngx.re.match(ngx.var.uri, base..rule.pattern)
			if m then
				rule.action()
			end
		end
	end
end

local dispatch = {}
table.insert(dispatch, {method="GET", pattern="/.+$", action=get_single_good})
table.insert(dispatch, {method="GET", pattern="/$", action=get_goods })
table.insert(dispatch, {method="POST", pattern="/$", action=add_good})
dispatch_request("^/api/goods", dispatch)

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
