module("storage", package.seeall)

local pgmoon = require "pgmoon"

function connect_db()
	local pg = pgmoon.new({
		host = "127.0.0.1",
		port = "5432",
		database = "dxm",
		user = "nando",
		password = "nando"
	})
	return pg
end

function get_user(pg,userid)
	local res = assert(pg:query("select * from users where username = '"..userid.."'"))
	if #res > 0 then
		return 200, res[1]
	else
		return 404
	end
end

function list_users(pg)
	local res = assert(pg:query("select * from users"))
	return res
end
