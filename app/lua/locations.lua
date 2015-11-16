local cjson = require "cjson"
local storage = require "storage"
local dispatcher = require "dispatcher"

local pg = storage.connect_db()
assert(pg:connect())


function get_single_location(matches)
	local locationid = matches[1]
	local status, location = storage.get_location(pg,locationid)
	if status == 200 then 
		ngx.say(cjson.encode(location))
	else
		ngx.exit(ngx.HTTP_NOT_FOUND)
	end
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

function update_location(match)
	ngx.req.read_body()
	local locationid = match[1]
	local loc = cjson.decode(ngx.req.get_body_data())
	local res, message = storage.update_location(pg, loc, locationid)
	if not res then
		ngx.log(ngx.ERR,message)
		ngx.exit(500)
	else
		ngx.exit(200)
	end
end



dispatcher.addrule("GET","/(.+)$",get_single_location)
dispatcher.addrule("GET","/?$",get_locations)
dispatcher.addrule("POST","/$",add_location)
dispatcher.addrule("PUT","/(.+)$",update_location)
dispatcher.dispatch("^/api/locations")


