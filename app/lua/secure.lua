local base32 = ngx.var.cookie_session
if (base32) then
	local binary = ndk.set_var.set_decode_base32(base32)
	local username = ndk.set_var.set_decrypt_session(binary)
	if username and username ~= "" then
		ngx.ctx.username = username;
		return
	end
end
ngx.say("failed authentication")

