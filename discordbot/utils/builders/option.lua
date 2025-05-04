local option_builder = {}
option_builder.__index = option_builder

function option_builder.new()
    return setmetatable({ data = {} }, option_builder)
end

function option_builder:Name(text)
    self.data.name = text
    return self
end


function option_builder:Label(text)
    self.data.label = text
    return self
end

function option_builder:Value(value)
    self.data.value = value
    return self
end

function option_builder:Description(text)
    self.data.description = text
    return self
end

function option_builder:Type(value)
    local type = slash_types[value] or application_types[value] or components[value] or value 
    self.data.type = value 
    return self 
end 

function option_builder:Required(value)
    self.data.required = value 
    return self
end 

function option_builder:Build()
    return self.data
end

return option_builder
