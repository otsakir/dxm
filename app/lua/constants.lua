module("constants", package.seeall)


OUTCOME = {
	OK = "ok",
	CONFLICT = "conflict",
	NOT_FOUND = "notfound",
	INTERNAL_ERROR = "internalerror"
}
setmetatable(OUTCOME, {
	__index = function (t,k)
		ngx.say("BAD CONSTANT VALUE!!")
	end
})

