module("dispatcher", package.seeall)

local rules = {}

function addrule(method, pattern, action, paramcount)
	table.insert(rules, {method=method, pattern=pattern, action=action})
end

function dispatch(base)
	local req_method = ngx.req.get_method()
	for i,rule in ipairs(rules) do
		if req_method == rule.method then
			local m = ngx.re.match(ngx.var.uri, base..rule.pattern)
			if m then
				rule.action(m)
			end
		end
	end
end
