--[[
op	Opcode (defines what type of payload it is)
t	Event type (e.g. MESSAGE_CREATE)
s	Sequence number (used for resuming sessions)
d	Data payload (actual message info, etc)
]]


-- Inclusions
local endpoints = include("info/endpoints")
local opcodes = include("info/opcodes")
local events  = include("info/events")

local payload = include("utils/payload")
local message = include("utils/message")

local Commands = {}
local Events   = {}
local websocket_modules = {
    new_command = function(options)
        local name = options.Name or options.name 
        local callback = options.Func or options.callback or options.Callback 

        Commands[name] = callback
    end,
    new_eventlistener = function(options)
        local event = options.Event or options.event 
        local callback = options.Func or options.callback or options.Callback 
        if not table.find(events, event) then 
            return warn(`Event with name {event} was not found. Look into the /info/events.lua file to get all discord events`)
        end 
        Events[event] = callback
    end 
}

for name, func in message do 
    setglobal(name, func)
end 

websocket_modules.login = function(tok)
    setglobal("token", tok)
    websocket_modules.start_connection()
end 

websocket_modules.start_connection = function()
    -- Websocket related
    local websocket = WebSocket.connect(endpoints.GATEWAY_URL)


    -- Heartbeat information
    local heartbeat_interval = 0
    local last_sequence = nil 
    local heartbeat_thread = nil 

    websocket.OnMessage:Connect(function(message)
        local data = payload.JsonDecode(message)
        local opcode, event_type, sequence_number, data_payload = data.op, data.t, data.s, data.d 
        local author = data.author

        if sequence_number then 
            last_sequence = sequence_number 
        end 

        if opcode == opcodes.HELLO then 
            heartbeat_interval = data_payload.heartbeat_interval
            websocket:Send(payload.identify_paylod(token))
            heartbeat_thread = task.spawn(function()
                while true do 
                    task.wait(heartbeat_interval / 1000)
                    websocket:Send(payload.heartbeat_paylod(last_sequence))
                end 
            end)
        elseif event_type == "MESSAGE_CREATE" then 
            local content = data_payload.content 
            local channel = data_payload.channel_id

            if Commands[content] then 
                Commands[content](content, channel, data_payload)
            end 
        elseif event_type == "INTERACTION_CREATE" then 
            local author = data_payload.member and data_payload.member.user
            local handler = ComponentHandlers[data_payload.data.custom_id]
            if handler then 
                local modal_data = {};
                
                if data_payload.data.components  then 
                    for _, component in data_payload.data.components do 
                        local fuck_you_discord_for_making_everything_so_shit = component.components
                        for i = 1, #fuck_you_discord_for_making_everything_so_shit do 
                            local comppp = fuck_you_discord_for_making_everything_so_shit[i]
                            modal_data[comppp.custom_id] = comppp.value
                        end 
                    end 
                end 

                handler({
                    username = author and author.username,
                    userid = author and author.id,
                    custom_id = data_payload.data and data_payload.data.custom_id,
                    component_type = data_payload.data and data_payload.data.component_type,
                    values = data_payload.data and data_payload.data.values, -- Select menus
                    channel_id = data_payload.channel_id,
                    guild_id = data_payload.guild_id,
                    message_id = data_payload.message and data_payload.message.id,
                    interaction_token = data_payload.token,
                    interaction_id = data_payload.id,
                    modal_data = modal_data
                })
            end 
        end 


        if Events[event_type] then 
            Events[event_type](data_payload)
        end 
    end)
end 

websocket_modules.WebSocket = websocket

return websocket_modules