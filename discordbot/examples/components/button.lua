bot.new_eventlistener({
    Event = "MESSAGE_CREATE",
    Callback = function(data)
        local is_bot = data.author.bot 
        if is_bot then return end 

        local message_id = data.id 
        local channel_id = data.channel_id

        local result = reply(channel_id, message_id, {
            Content = "Hello world",
            Embeds = {{
                title = "Hi",
                description = "Test"
            }},
            Components = {{
                type = components["Action Row"],
                components = {{
                    type = components["Button"],
                    label = "I'm a button",
                    custom_id = "test_id",
                    style = styles["Success"]
                }}
            }}
        })

    end 
})

bot.new_componenthandler({
    Custom_id = "test_id",
    Callback  = function(info)
        local interaction_token = info.interaction_token
        local interaction_id = info.interaction_id
        update_message(interaction_id,interaction_token, { 
            content = "Button was pressed",
            embeds = {},
            components = {}
        } )
    end     
})
