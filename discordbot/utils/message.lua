local payload = include("utils/payload")
local endpoints = include("info/endpoints")
local components = include("info/components")
local reply_types = include("info/reply_types")

local message = {}
setglobal("styles", components.ButtonStyles)
setglobal("modal_types", components.ModalTypes)

setglobal("components", components)
setglobal("reply_types", reply_types)

message.insert_handles = function(components, handlers)
    for _, component in components do 
        local components_ = component.components
        for _, component in components_ do 
            local custom_id = component.custom_id
            local handler = handlers[custom_id]
            if not handler then continue end 

            ComponentHandlers[custom_id] = handlers[custom_id]
        end 
    end 
end 

message.send = function(body, channel_id)
    return request({
        Url = "https://discord.com/api/v10"..endpoints.CHANNEL_MESSAGES:format(channel_id),
        Method = "POST",
        Headers = payload.get_headers(token),
        Body = body
    })
end 

message.send_raw = function(channel_id, data) 
    local message = payload.JsonEncode(data)
    local result = message.send(message, channel_id)

    return result
end 

message.reply = function(channel_id, message_id, content)
    local body = payload.JsonEncode({
        content = content.Content,
        embeds = content.Embeds,
        components = content.Components,
        message_reference = {
            message_id = message_id,
            channel_id = channel_id
        }
    })

    return message.send(body, channel_id)
end 


message.send_message = function(channel_id, message) 
    local message = payload.JsonEncode({ content = message })
    local result = message.send(message, channel_id)

    return result
end 

message.send_embed = function(channel_id, embed)
    assert(embed.Embed ~= nil, "Expected 'Embed' to be in the embed table")
    local data = {
        content = embed.Content,
        embeds = embed.Embed,
        
    }
    local body = payload.JsonEncode(data)
    local result = message.send(body, channel_id)

    return result 
end 

message.send_components = function(channel_id, components, handlers)
    local body = payload.JsonEncode({ components = components })
    local result = message.send(body, channel_id)

    message.insert_handles(components, handlers)

    return result
end 

message.update_message = function(interaction_id, interaction_token, updated_content)
    local url  = `https://discord.com/api/v10/interactions/{interaction_id}/{interaction_token}/callback`
    local body = payload.JsonEncode({
        type = reply_types.UPDATE_MESSAGE,
        data = updated_content
    })
    
    return request({
        Url = url, 
        Headers = payload.get_headers(token),
        Method = "POST",
        Body = body
    })
end 

message.send_modal = function(interaction_id, interaction_token, datax, handler)
    local url  = `https://discord.com/api/v10/interactions/{interaction_id}/{interaction_token}/callback`
    local body = payload.JsonEncode({
        type = reply_types.MODAL,
        data = datax
    })

    local custom_id = datax.custom_id
    ComponentHandlers[custom_id] = handler

    return request({
        Url = url, 
        Body = body, 
        Headers = payload.get_headers(token),
        Method = "POST"
    })
end 

message.delete = function(channel_id, message_id)
    local url = "https://discord.com/api/v10"..endpoints.CHANNEL_MESSAGE:format(channel_id, message_id)

    return request({
        Url = url,
        Method = "DELETE",
        Headers = payload.get_headers(token)
    })
end 

message.add_reaction = function(channel_id, message_id, emoji)
    local emoji = payload.url_encode(emoji)
    local url = "https://discord.com/api/v10"..endpoints.CHANNEL_MESSAGE_REACTION_ME:format(channel_id, message_id, emoji)

    return request({
        Url = url, 
        Method = "PUT",
        Headers = payload.get_headers(token)
    })
end 

message.get_reactions = function(channel_id, message_id, emoji)
    local emoji = payload.url_encode(emoji)
    local url = "https://discord.com/api/v10"..endpoints.CHANNEL_MESSAGE_REACTION:format(channel_id, message_id, emoji)

    local body = payload.JsonDecode(request({
        Url = url, 
        Method = "GET",
        Headers = payload.get_headers(token)
    }).Body)

    return body
end 

message.delete_reactions = function(channel_id, message_id, emoji)
    local emoji = payload.url_encode(emoji)
    local url = "https://discord.com/api/v10"..endpoints.CHANNEL_MESSAGE_REACTION:format(channel_id, message_id, emoji)

    return request({
        Url = url, 
        Method = "DELETE",
        Headers = payload.get_headers(token)
    })
end 

return message, components
