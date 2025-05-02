-- Updating text and adding new embeds
bot.new_command({
    Name = "!test",
    Callback = function(content, channeld_id, data_payload)
        local example_component = {{
            type = components["Action Row"],
            components = {{
                type = components["Button"],
                style = styles["Primary"],
                label = "Test",
                custom_id = "test_id"
            }}
        }}

        -- Handler: 
        -- [custom_id] = callback
        local example_handler = {
            ["test_id"] = function(info) -- 
                local interaction_token = info.interaction_token
                local interaction_id = info.interaction_id
                local updated_component =  {{
                        type = components["Action Row"],
                        components = {{
                            type = components["Button"],
                            style = styles["Danger"],
                            label = "Component was pressed",
                            custom_id = "pressed_id"
                        }}
                    }}
                local updated_embed = {
                    title = "Test",
                    description = "test",
                    color = 0x5865F2, 
                }
                local updated_stuff = {
                    components = updated_component,
                    embeds = { updated_embed }
                }
                update_message(interaction_id, interaction_token, updated_stuff)
            end 
        }

        send_components(channeld_id, example_component, example_handler)
    end 
})


-- Modals
bot.new_command({
    Name = "!test2",
    Callback = function(content, channeld_id, data_payload)
        local example_component = {{
            type = components["Action Row"],
            components = {{
                type = components["Button"],
                style = styles["Primary"],
                label = "Test",
                custom_id = "test_id"
            }}
        }}

        -- Handler: 
        -- [custom_id] = callback
        local example_handler = {
            ["test_id"] = function(info) -- 
                local interaction_token = info.interaction_token
                local interaction_id = info.interaction_id
                local updated_component = {
                    custom_id = "modal_id",
                    title = "Enter info",
                    components = {{
                        type = components["Action Row"],
                        components = {{
                            type = components["Text Input"],
                            custom_id = "example_input",
                            style = modal_types.SHORT,
                            label = "Password",
                            required = true 
                        }}
                    }}
                }
                send_modal(interaction_id, interaction_token, updated_component, function(info)
                    local modal = info.modal_data 
                    if modal["example_input"] == "udd" then 
                        update_message(info.interaction_id, info.interaction_token, { content = "WE ARE UD", components = {}})
                    end 
                end)
            end 
        }

        send_components(channeld_id, example_component, example_handler)
    end 
})

-- Simple listener to MESSAGE_CREATE event. Events can be found in info/events.lua
bot.new_eventlistener({
    Event = "MESSAGE_CREATE",
    Callback = function(data)
        local content = data.content 
        warn(content)
    end 
})

bot.login("token here")