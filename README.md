# discord-bot-luau
A discord bot purely written in luau. This is ment to be used with executors and does not run natively on luau
(Ignore that the files end with .lua I forgot to change it when editing)
--------------------------------------------------------------------------------------------------------------------------------------------------------
# How to set it up
```luau
local bot = loadstring(game:HttpGet("https://raw.githubusercontent.com/penguin-cmyk/discord-bot-luau/refs/heads/main/discordbot/init.lua"))()

bot.new_command({
    Name = ".test",
    Callback = function(content, channel_id, data)
      print(content, channel_id)
      table.foreach(data, print)
    end 
})


bot.login("token")
```
### Example can found in the examples folder
--------------------------------------------------------------------------------------------------------------------------------------------------------

What is planned?
- Functions like reply, delete message, get reactions, add reaction
- A proper documentation. (The current documentation is just looking at the source or the example)
