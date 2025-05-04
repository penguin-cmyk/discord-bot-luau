local component_builder = {}
component_builder.__index = component_builder

local option_builder = include("utils/builders/option")

setglobal("option_builder", option_builder)

component_builder.new = function()
    return setmetatable({
        data = {}
    }, component_builder)
end 

function component_builder:Type(value)
    local type = components[value] or value 
    self.data.type = type 
    return self 
end 

function component_builder:Title(value)
    self.data.title = value 
    return self 
end 


function component_builder:AddComponent(component)
    if not self.data.components then 
        self.data.components = {}
    end 

    table.insert(self.data.components, component.data )
    return self 
end 

function component_builder:Label(value)
    self.data.label = value 
    return self
end 

function component_builder:CustomId(value)
    self.data.custom_id = value 
    return self
end 

function component_builder:Style(value)
    local style = styles[value] or value 
    self.data.style = style
    return self 
end 

function component_builder:MinValue(value)
    self.data.min_values = value
    return self
end 

function component_builder:MaxValue(value)
    self.data.max_values  = value
    return self
end

function component_builder:Placeholder(value)
    self.data.placeholder  = value
    return self
end

function component_builder:Required(value)
    self.data.required  = value
    return self
end

function component_builder:Options(value)
    self.data.options = value
    return self
end

function component_builder:Build()
    return self.data
end

return component_builder