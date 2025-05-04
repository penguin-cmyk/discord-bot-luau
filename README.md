# discord-bot-luau
## A discord bot purely written in luau. This is ment to be used with executors or lune!


### (Ignore that the files end with .lua I forgot to change it when editing)
--------------------------------------------------------------------------------------------------------------------------------------------------------
# How to set it up
# Executors
```luau
local bot = loadstring(game:HttpGet("https://raw.githubusercontent.com/penguin-cmyk/discord-bot-luau/refs/heads/main/discordbot/init.lua"))()
bot.Config = { self_bot = false }
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
local bot = require("./discordbot/init.lua") -- it is NEEDED for the folder to be called discordbot else you would need to change the src up a bit (just the init file and that's all)
bot.Config = { self_bot = false }
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
Documentation: https://penguins-organization-2.gitbook.io/pengublog/dahood/discord-bot/introduction
--------------------------------------------------------------------------------------------------------------------------------------------------------

What is planned?
- Functions like reply, delete message, get reactions, add reaction
