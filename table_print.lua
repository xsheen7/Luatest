--[[
	* ��ӡ table
	* @param  {any} val     ����ֵ
	* @return {str}         ��ʽ������ı�
]]
function table_print (val)

	local function loop (val, keyType, _indent)
		_indent = _indent or 1
		keyType = keyType or "string"
		local res = ""
		local indentStr = "     " -- �����ո�
		local indent = string.rep(indentStr, _indent)
		local end_indent = string.rep(indentStr, _indent - 1)
		local putline = function (...)
			local arr = { res, ... }
			for i = 1, #arr do
				if type(arr[i]) ~= "string" then arr[i] = tostring(arr[i]) end
			end
			res = table.concat(arr)
		end

		if type(val) == "table" then
			putline("{ ")

			if #val > 0 then
				local index = 0
				local block = false

				for i = 1, #val do
					local n = val[i]
					if type(n) == "table" or type(n) == "function" then
						block = true
						break
					end
				end

				if block then
					for i = 1, #val do
						local n = val[i]
						index = index + 1
						if index == 1 then putline("\n") end
						putline(indent, loop(n, type(i), _indent + 1), "\n")
						if index == #val then putline(end_indent) end
					end
				else
					for i = 1, #val do
						local n = val[i]
						index = index + 1
						putline(loop(n, type(i), _indent + 1))
					end
				end

			else
				putline("\n")
				for k, v in pairs(val) do
					putline(indent, k, " = ", loop(v, type(k), _indent + 1), "\n")
				end
				putline(end_indent)
			end

			putline("}, ")
		elseif type(val) == "string" then
			val = string.gsub(val, "\a", "\\a") -- ����(BEL)
			val = string.gsub(val, "\b", "\\b") -- �˸�(BS),����ǰλ���Ƶ�ǰһ��
			val = string.gsub(val, "\f", "\\f") -- ��ҳ(FF),����ǰλ���Ƶ���ҳ��ͷ
			val = string.gsub(val, "\n", "\\n") -- ����(LF),����ǰλ���Ƶ���һ�п�ͷ
			val = string.gsub(val, "\r", "\\r") -- �س�(CR),����ǰλ���Ƶ����п�ͷ
			val = string.gsub(val, "\t", "\\t") -- ˮƽָ��(HT),(������һ��TABλ��)
			val = string.gsub(val, "\v", "\\v") -- ��ֱָ��(VT)
			putline("\"", val, "\", ")
		elseif type(val) == "boolean" then
			putline(val and "true, " or "false, ")
		elseif type(val) == "function" then
			putline(tostring(val), ", ")
		elseif type(val) == "nil" then
			putline("nil, ")
		else
			putline(val, ", ")
		end

		return res
	end

	local res = loop(val)
	res = string.gsub(res, ",(%s*})", "%1")
	res = string.gsub(res, ",(%s*)$", "%1")
	res = string.gsub(res, "{%s+}", "{}")

	return res
end

t={1,2,{3,4,{5,6}}}

print(table_print(t))
