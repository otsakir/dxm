local cjson = require "cjson"
local storage = require "storage"

local pg = storage.connect_db()
assert(pg:connect())

if (ngx.var.request_method == "GET") then
	if ngx.var.userid then
		local status, user = storage.get_user(pg,ngx.var.userid)
		if status == 200 then 
			ngx.say(cjson.encode(user))
		else
			--ngx.status = ngx.HTTP_NOT_FOUND
			ngx.exit(ngx.HTTP_NOT_FOUND)
		end
	else
		ngx.say(cjson.encode(storage.list_users(pg)))
	end
elseif (ngx.var.request_method == "POST") then
	ngx.say("received POST")
end


