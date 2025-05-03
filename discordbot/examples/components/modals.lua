bot.new_command({
    Name = "!modal",
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

        local example_handler = {
            -- ["test_id"] will fire once the button is pressed
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
                            style = modal_types.SHORT, -- SHORT, PARAGRAPH
                            label = "Password",
                            required = true 
                        }}
                    }}
                }

                -- send modal will take thge custom_id from your "updated_component" table
                -- so e.g modal_id
                -- which means you will not need to add your own handling for that id
                -- why? Because on the INTERACTION_CREATE event only this is the custom_id which is registered
                -- when input is pressed 

                send_modal(interaction_id, interaction_token, updated_component, function(info) 
                    local modal = info.modal_data 
                    -- modal data strucute is:
                    -- modal[custom_id] = input 
                    -- since our "Password" inputs custom_id is "example_input" we will check for for that

                    if modal["example_input"] == "udd" then 
                        update_message(info.interaction_id, info.interaction_token, { content = "WE ARE UD", components = {}})
                    end 
                end)
            end 
        }

        send_components(channeld_id, example_component, example_handler)
    end 
})