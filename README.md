### What is Pengubot?
PenguBot is a simple discord bot framework that I've been working on for fun since I was bored. 
It's a cool side project and is not meant to be a really "serious" discord bot framework but I has similar features to one.

### What does it support?
- PenguBot can be run in either a roblox executor env. which supports wss Websockets.
- Another method is to run it using [Lune](https://github.com/lune-org/lune). 
- The file will automatically detect when you're using lune or a executor env. 

### How to set it up?
> Executor env: 
```lua
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

 > Lune env  (clone the repository first and cd into it):
```lua
--[[
	It is needed for the folder to be called "discordbot".
	If you don't want it to be called "discordbot" goto init.lua
	And change the name to something else
]]
local bot = require("./discordbot/init.lua") 
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

### Where is the documentation?
[The documentation can be found here](https://penguins-organization-2.gitbook.io/pengublog/dahood/discord-bot/introduction) 

### What is planned?
Currently it is planned to add support for more functions to make it seamless to integrate it into your project and actually use it. 
