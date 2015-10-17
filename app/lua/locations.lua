local cjson = require "cjson"
local storage = require "storage"

local pg = storage.connect_db()
assert(pg:connect())

if (ngx.var.request_method == "POST") then
	-- read location from request
	ngx.req.read_body()
	local body = ngx.req.get_body_data()
	local loc = cjson.decode(body)
	-- store location to db
	local res, message = storage.create_location(pg,loc)
	if not res then
		ngx.say(message)
		ngx.exit(500)
		
		-- log the error
	else
		ngx.say(cjson.encode(res))
	end
elseif (ngx.var.request_method == "GET" and not ngx.var.locationid) then
	local res, message = storage.list_locations(pg)
	if not res then
		ngx.exit(404) -- treat all errors as NOT_FOUND
	else
		ngx.say(cjson.encode(res))
	end
end

