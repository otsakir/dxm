local cjson = require "cjson"
local storage = require "storage"
local dispatcher = require "dispatcher"

local pg = storage.connect_db()
assert(pg:connect())


function get_single_location(matches)
	ngx.exit(501) -- not implemented
end

function get_locations()
	local res, message = storage.list_locations(pg)
	if not res then
		ngx.exit(404) -- treat all errors as NOT_FOUND
	else
		ngx.say(cjson.encode(res))
	end
end

function add_location()
	ngx.req.read_body()
	local body = ngx.req.get_body_data()
	local loc = cjson.decode(body)
	-- store location to db
	local res, message = storage.create_location(pg,loc,ngx.ctx.username)
	if not res then
		ngx.log(ngx.ERR,message)
		ngx.exit(500)
	else
		ngx.say(cjson.encode(res))
	end
end


dispatcher.addrule("GET","/(.+)$",get_single_location)
dispatcher.addrule("GET","/?$",get_locations)
dispatcher.addrule("POST","/$",add_location)
dispatcher.dispatch("^/api/locations")


