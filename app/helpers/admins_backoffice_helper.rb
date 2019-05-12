module AdminsBackofficeHelper
    def translate_attributes(object = nil, method = nil)
        if object && method
            object.model.human_attribute_name(method) 
        end
    end
end
