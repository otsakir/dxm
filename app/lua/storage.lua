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
	local res = assert(pg:query("select * from users where username = ".. pg:escape_literal(userid)))
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

function list_locations(pg)
	local res = assert(pg:query("select * from locations"))
	return res
end

function create_location(pg, loc)
	local id = uuid4.getUUID()
	local query = build_insert_query(pg, "locations", {"sid","name","address","lat","lng"}, {id,loc.name,loc.address,loc.lat,loc.lng})
	ngx.say(query)
	local res,message = pg:query(query)
	if not res then
		return res,message
	else
		loc.sid = id
		return loc
	end
end

function build_insert_query(pg, table_name, fields, values)
	local fields_part = ""
	local values_part = ""
	if fields[1] and values[1] then
		fields_part = fields_part..fields[1]
		values_part = values_part..pg:escape_literal(values[1])
	end
	local i = 2
	while fields[i] and values[i] do
		fields_part = fields_part..","..fields[i]
		values_part = values_part..","..pg:escape_literal(values[i])		
		i = i+1
	end
	return "INSERT into "..table_name.."("..fields_part..") values ("..values_part..")"
end

