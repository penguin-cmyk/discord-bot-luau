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

local function getcallback(options) return options.Func or options.callback or options.Callback end 

local websocket_modules = {
    new_command = function(options)
        local name = options.Name or options.name 
        local callback = getcallback(options)

        assert(callback ~= nil, "Callback expected got nil")
        assert(typeof(callback) == "function", "Function expected as callback got "..typeof(callback))
        
        assert(name ~= nil, "name expected got nil")
        assert(typeof(name) == "string", "String expected for the name got "..typeof(name))

        Commands[name] = callback
    end,
    new_eventlistener = function(options)
        local event = options.Event or options.event 
        local callback = getcallback(options) 


        assert(callback ~= nil, "Callback expected got nil")
        assert(typeof(callback) == "function", "Function expected as callback got "..typeof(callback))
        
        assert(event ~= nil, "event expected got nil")
        assert(typeof(event) == "string", "String expected for the event got "..typeof(event))
        

        if not table.find(events, event) then 
            return warn(`Event with name {event} was not found. Look into the /info/events.lua file to get all discord events`)
        end 
        Events[event] = callback
    end,
    new_componenthandler = function(options)
        local custom_id = options.id or options.Id or options.custom_id or options.Custom_id
        local callback = getcallback(options)

        assert(callback ~= nil, "Callback expected got nil")
        assert(typeof(callback) == "function", "Function expected as callback got "..typeof(callback))
        
        assert(custom_id ~= nil, "custom_id expected got nil")
        assert(typeof(custom_id) == "string", "String expected for the custom_id got "..typeof(custom_id))

        ComponentHandlers[custom_id] = callback
    end 
}

for name, func in message do 
    setglobal(name, func)
end 

setglobal("payload", payload)

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
                        local comp = component.components
                        for i = 1, #comp do 
                            local comppp = comp[i]
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

setmetatable(websocket_modules, {
    __newindex = function(self, key, value)
        if key == "Config" then 
            setglobal("bot_config", value)
        end 
    end,
})


return websocket_modules
