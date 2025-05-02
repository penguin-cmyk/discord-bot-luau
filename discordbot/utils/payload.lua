local payload = {}
local http_service = game:GetService("HttpService")

local op_codes = include("info/opcodes")

payload.JsonEncode = function(table) return http_service:JSONEncode(table) end 
payload.JsonDecode = function(table) return http_service:JSONDecode(table) end 

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
    return { ["Content-Type"] = "application/json", ["Authorization"] = "Bot "..token }
end 

return payload