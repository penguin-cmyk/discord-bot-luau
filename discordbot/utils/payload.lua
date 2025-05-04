local payload = {}
local op_codes = include("info/opcodes")

payload.JsonEncode = function(table)
    return is_lune and JsonEncode(table) or game:GetService("HttpService"):JSONEncode(table) 
end 
payload.JsonDecode = function(table) 
    return is_lune and JsonDecode(table) or game:GetService("HttpService"):JSONDecode(table) 
end 

payload.identify_paylod = function(token_input)
    local data = {
        token = token_input,
        intents = 53608447, -- all intents (https://discord-intents-calculator.vercel.app/)
        properties = {
            os = "linux",
            browser = "discord",
            device = "discord"
        }
    }
    return payload.JsonEncode({
        op = op_codes.IDENTIFY,
        d = data
    })
end 

payload.heartbeat_paylod = function(sequence_number)
    return payload.JsonEncode({
        op = op_codes.HEARTBEAT,
        d = sequence_number
    })
end 

payload.get_headers = function(token)
    local config = bot_config.self_bot and token or ("Bot "..token)
    return { ["Content-Type"] = "application/json", ["Authorization"] = config }
end 

payload.url_encode = function(str)
	return str:gsub("[^%w%-._~]", function(char)
		return string.format("%%%02X", string.byte(char))
	end)
end

return payload
