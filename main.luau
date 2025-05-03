-- This is just a example of how the main.luau for a lune runtime could look like
--!nocheck
local bot = require("./discordbot/init")
bot.Config = {
    self_bot = false,
}


bot.new_eventlistener({
    Event = "MESSAGE_CREATE",
    Callback = function(data)
        local is_bot = data.author.bot 
        if is_bot then return end 

        local channel_id = data.channel_id
        local message_id = data.id 

        add_reaction(channel_id, message_id, "💔")
        task.wait(5)
        delete_reactions(channel_id, message_id, "💔")
    end 
})


bot.login("")
