# discord-bot-luau
## A discord bot purely written in luau. This is ment to be used with executors or lune!


### (Ignore that the files end with .lua I forgot to change it when editing)
--------------------------------------------------------------------------------------------------------------------------------------------------------
# How to set it up
# Executors
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

# Lune
```luau
local bot = require("discordbot/init.lua")

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
