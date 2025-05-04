local repo = "https://raw.githubusercontent.com/penguin-cmyk/discord-bot-luau/refs/heads/main/"
local discordbot = repo.."/discordbot"
local utils = discordbot.."/utils"
local info  = discordbot.."/info"

local is_lune, libs = pcall(function() 
    local libs = { 
        net = require("@lune/net"), 
        task = require("@lune/task"), 
        fs = require("@lune/fs"), 
        luau = require("@lune/luau")
    } 
    return libs
end)

if is_lune then 
    getfenv(0).getgenv = function() return getfenv(0) end
end 

getgenv().setglobal = function(name, value) 
    getgenv()[name] = value 
end 

if is_lune then 
    local fs    = libs.fs 
    local net   = libs.net 
    local task  = libs.task
    local luau  = libs.luau 

    local json = require("./json/json")
    
    -- Heartbeat information
    local heartbeat_interval = 0
    local last_sequence = nil 
    local heartbeat_thread = nil 


    local WebSocket = {
        connect = function(ws)
            local ws = net.socket(ws)
            local ws_table = {}

            ws_table.OnMessage = {}
            function ws_table.OnMessage:Connect(func)
                task.spawn(function()
                    while true do 
                        local message = ws:next()
                        func(message)
                    end 
                end)
            end 

            function ws_table:Send(message)
                return ws:send(message)
            end 

            return ws_table 
        end, 
    }

    setglobal("is_lune", is_lune);
    setglobal("isfolder", fs.isfolder)

    setglobal("loadstring", function(code)
        local bytecode = luau.compile(code)
        local compiled_func = luau.load(bytecode)

        return compiled_func
    end)

    setglobal("include", function(path)
        local path = fs.isFile(`{path}.lua`) and `{path}.lua` or fs.isFile(`discordbot/{path}.lua`) and `discordbot/{path}.lua`
        return loadstring(fs.readFile(path))()
    end)

    setglobal("request", function(options)
        return net.request({
            url = options.Url,
            method = options.Method,
            headers = options.Headers,
            body = options.Body
        })
    end)

    setglobal("JsonEncode", json.encode)
    setglobal("JsonDecode", json.decode)

    setglobal("task", task)
    setglobal("WebSocket", WebSocket)
end 


if not is_lune then 
    local function check(path) if not isfolder(path) then makefolder(path) end end
    check("discordbot")
    check("discordbot/utils")
    check("discordbot/info")

    local info_files = { "components.lua",
                        "reply_types.lua",
                        "endpoints.lua",
                        "opcodes.lua",
                        "events.lua"
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
end 

setglobal("ComponentHandlers", {})

local bot = include("utils/websocket")
return bot 


