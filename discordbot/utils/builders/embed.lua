local embed_builder = {}
embed_builder.__index = embed_builder

embed_builder.new = function()
    return setmetatable({
        data = { fields = {} }
    }, embed_builder)
end

function embed_builder:Title(title)
    self.data.title = title 
    return self 
end 

function embed_builder:Description(description)
    self.data.description = description 
    return self 
end 

function embed_builder:Color(color)
    self.data.color = color 
    return self 
end 

function embed_builder:Footer(text, icon_url)
    self.data.footer = { text = text, icon_url = icon_url }
    return self 
end 

function embed_builder:Text(text)
    self.data.text = text
    return self 
end 

function embed_builder:Author(author, icon_url)
    self.data.author = { name  = author, icon_url = icon_url }
    return self 
end 

function embed_builder:AddField(field)
    table.insert(self.data.fields, field)
    return self 
end 


function embed_builder:IconUrl(url)
    self.data.icon_url = url 
    return self 
end 

function embed_builder:Thumbnail(url_)
    self.data.thumbnail = { url = url_ } 
    return self 
end

function embed_builder:Image(url_)
    self.data.image = { url = url_ } 
    return self 
end




function embed_builder:Build()
    return self.data 
end 

return embed_builder