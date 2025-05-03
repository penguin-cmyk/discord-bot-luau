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
                    type = components["Select Menu"],
                    placeholder = "I'm a select menu",
                    custom_id = "test_id",

                    min_values = 1,
                    max_values = 1,

                    options = {
                        {
                            label = "Option One",
                            value = "one",
                            description = "This is the first option"
                        },
                        {
                            label = "Option Two",
                            value = "two",
                            description = "This is the second option"
                        }
                    }
                }}
            }}
        })

    end 
})

bot.new_componenthandler({
    Custom_id = "test_id",
    Callback  = function(info)
        local selected_values = info.values
        local interaction_token = info.interaction_token
        local interaction_id = info.interaction_id
        
        update_message(interaction_id,interaction_token, { 
            content = `Selected: {selected_values[1]}`,
            embeds = {},
            components = {}
        })
    end     
})