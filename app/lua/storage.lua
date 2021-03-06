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

-- user API --

function get_user(pg,userid)
	local res = assert(pg:query("select * from members where username = ".. pg:escape_literal(userid)))
	if #res > 0 then
		return 200, res[1]
	else
		return 404
	end
end

function list_users(pg)
	local res = assert(pg:query("select * from members"))
	return res
end

function add_user(pg, user)
	local id = uuid4.getUUID()
	local query = build_insert_query(pg, "members", {"sid", "name","username","is_producer","is_consumer"}, {id,user.name,user.username,user.is_producer,user.is_consumer})
	local res,message = pg:query(query)
	if not res then
		return res,message
	else
		user.sid = id
		return user
	end
end

function remove_user(pg, userid)
	assert(userid)
	local query = build_remove_query(pg, "members", {sid=userid})
	ngx.log(ngx.ERR,query)
	return pg:query(query)
end

-- location API --

function list_locations(pg)
	local res = assert(pg:query("select * from locations"))
	return res
end

function get_location(pg,locationid)
	local query = "select * from locations where sid = ".. pg:escape_literal(locationid)
	local res = assert(pg:query(query))
	if #res > 0 then
		return 200, res[1]
	else
		return 404
	end
end

function create_location(pg, loc, userid)
	local id = uuid4.getUUID()
	local query = build_insert_query(pg, "locations", {"sid","member_sid", "name","address","lat","lng"}, {id,userid,loc.name,loc.address,loc.lat,loc.lng})
	--ngx.say(query)
	local res,message = pg:query(query)
	if not res then
		return res,message
	else
		loc.sid = id
		return loc
	end
end

function update_location(pg, loc, location_sid)
	local query = build_update_query(pg, "locations", {"name","address","lat","lng"}, {loc.name,loc.address,loc.lat,loc.lng}, {sid = location_sid})
	local res,message = pg:query(query)
	if not res then
		return res,message
	else
		return true;
	end
end

-- goods API --

function list_goods(pg)
	return assert(pg:query("select * from goods"))
end

function get_good(pg,goodid)
	local res = assert(pg:query("select * from goods "..predicate_clause({sid=goodid})))
	if #res > 0 then
		return res[0], OUTCOME.OK
	else
		return nil, OUTCOME.NOT_FOUND
	end
end

-- lower level functions --

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

function build_update_query(pg, table_name, fields, values, predicates)
	if fields[1] and values[1] then
		local query_body = "SET "..fields[1].." = "..pg:escape_literal(values[1])
		local i = 2
		while fields[i] and values[i] do
			query_body = query_body..", "..fields[i].." = "..pg:escape_literal(values[i])
			i = i+1
		end
		return "UPDATE "..table_name.." "..query_body.." "..predicate_clause(predicates)
	end
end

function build_remove_query(pg, table_name, predicates)
	return "DELETE from "..table_name.." "..predicate_clause(predicates)
end

function predicate_clause(predicates)
	local predicate_clause = ""
	if predicates then
		predicate_clause = "WHERE "
		local c = 0
		for i,v in pairs(predicates) do
			if c > 0 then predicate_clause = predicate_clause.." AND " end
			predicate_clause = predicate_clause..i.." = "..pg:escape_literal(v)
			c = c + 1
		end
	end
	return predicate_clause
end
