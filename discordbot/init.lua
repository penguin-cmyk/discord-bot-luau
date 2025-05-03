local repo = "https://raw.githubusercontent.com/penguin-cmyk/discord-bot-luau/refs/heads/main/"
local discordbot = repo.."/discordbot"
local utils = discordbot.."/utils"
local info  = discordbot.."/info"

local function check(path) if not isfolder(path) then makefolder(path) end end
getgenv().setglobal = function(name, value) getgenv()[name] = value end 


check("discordbot")
check("discordbot/utils")
check("discordbot/info")

local info_files = { "components.lua",
                     "reply_types.lua"
                     "endpoints.lua",
                     "opcodes.lua",
                     "events.lua",
                   }

local utils_file = { "message.lua",
                     "payload.lua",
                     "websocket.lua"
                    }

for i = 1, #info_files do 
    local file_name = info_files[i]
    local path = `discordbot/info/{file_name}`

    writefile(path, game:HttpGet(`{info}/{file_name}`))
end 

for i = 1, #utils_file do 
    local file_name = utils_file[i]
    local path = `discordbot/utils/{file_name}`

    writefile(path, game:HttpGet(`{utils}/{file_name}`))
end 


setglobal("include", function(path) return loadfile(`discordbot/{path}.lua`)() end)
setglobal("ComponentHandlers", {})

local bot = include("utils/websocket")
return bot 


