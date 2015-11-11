local cjson = require "cjson"

ngx.say(cjson.encode({
	a = 5
}))
