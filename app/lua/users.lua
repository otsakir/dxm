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
	ngx.exit(501)
end




dispatcher.addrule("GET","/(.+)$",get_single_user)
dispatcher.addrule("GET","/?$",get_users)
dispatcher.addrule("POST","/$",add_user)
dispatcher.dispatch("^/api/users")
