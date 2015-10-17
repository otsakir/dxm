local storage = require "storage"
local cjson = require "cjson"

local pg = storage.connect_db()
assert(pg:connect())

function login(username,password)
	local status, user = storage.get_user(pg,username)
	if status == 200 then 
		local expires = 3600 * 24  -- 1 day
		local binary = ndk.set_var.set_encrypt_session(username)
		local base32 = ndk.set_var.set_encode_base32(binary)
		ngx.header["Set-Cookie"] = "session=" .. base32.. "; Expires=" .. ngx.cookie_time(ngx.time() + expires) 	
		return true;
	else
		return false;
	end
end

local username = ngx.var.arg_username
local password = ngx.var.arg_password
-- validate request params here
if not username or not password then
	ngx.exit(ngx.HTTP_BAD_REQUEST)
	return
end	

if not login(username, password) then
	ngx.exit(ngx.HTTP_UNAUTHORIZED)
end
