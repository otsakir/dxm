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

function get_user(userid)
	local res = assert(pg:query("select * from users where username = '"..userid.."'"))
	if #res > 0 then
		return 200, res[1]
	else
		return 404
	end
end

assert(pg:connect())

if (ngx.var.request_method == "GET") then
	if ngx.var.userid then
		local status, user = get_user(ngx.var.userid)
		if status == 200 then 
			ngx.say(cjson.encode(user))
		else
			--ngx.status = ngx.HTTP_NOT_FOUND
			ngx.exit(ngx.HTTP_NOT_FOUND)
		end
	else
		ngx.say(cjson.encode(list_users()))
	end
elseif (ngx.var.request_method == "POST") then
	ngx.say("received POST")
end


