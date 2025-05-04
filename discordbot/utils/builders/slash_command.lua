local slash_builder = {}

local application_types = include("info/application_types")
setglobal("application_types", application_types)

slash_builder.__index = slash_builder

slash_builder.new = function()
    return setmetatable({
        data = {}
    }, slash_builder)
end 

function slash_builder:Name(name)
    self.data.name = name
    return self
end 

function slash_builder:Description(description)
    self.data.description = description
    return self 
end 

function slash_builder:Type(type)
    local type = application_types[type] or slash_types[type] or type 
    self.data.type = type
    return self 
end 

function slash_builder:Options(value)
    self.data.options = value
    return self
end

function slash_builder:Build()
    return self.data 
end 

return slash_builder