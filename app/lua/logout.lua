ngx.header["Set-Cookie"] = "session=deleted; Expires=Thu, 01 Jan 1970 00:00:00 GMT"	
--Set-Cookie: token=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT
ngx.exit(401)

