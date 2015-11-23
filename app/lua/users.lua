local cjson = require "cjson"
local storage = require "storage"
local dispatcher = require "dispatcher"

local pg = storage.connect_db()
assert(pg:connect())

function get_single_user(matches)
	local userid = matches[1]
	ngx.log(ngx.ERR, "userid: "..userid)
	local status, user = storage.get_user(pg,userid)
	if status == 200 then 
		ngx.say(cjson.encode(user))
	else
		ngx.exit(ngx.HTTP_NOT_FOUND)
	end
end

function get_users()
	ngx.say(cjson.encode(storage.list_users(pg)))
end

function add_user()
	ngx.req.read_body()
	local body = ngx.req.get_body_data()
	local user = cjson.decode(body)
	user.is_producer = user.is_producer or 0
	user.is_consumer = user.is_consumer or 0
	local res, message = storage.add_user(pg,user)
	if not res then
		ngx.log(ngx.ERR,message)
		ngx.exit(500)
	else
		ngx.say(cjson.encode(res))
	end
end

function remove_user(matches)
	local userid = matches[1]
	local res, message = storage.remove_user(pg,userid)
	if not res then
		ngx.log(ngx.ERR,message)
		ngx.exit(500)
	else
		ngx.exit(200)
	end
end


dispatcher.addrule("GET","/(.+)$",get_single_user)
dispatcher.addrule("GET","/?$",get_users)
dispatcher.addrule("POST","/$",add_user)
dispatcher.addrule("DELETE","/(.+)$", remove_user)
dispatcher.dispatch("^/api/users")
