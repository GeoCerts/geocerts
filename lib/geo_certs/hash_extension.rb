require 'libxml'

class Hash # :nodoc:
  class << self
        def from_libxml(xml, strict=true)
          begin
            LibXML::XML.default_load_external_dtd = false
            LibXML::XML.default_pedantic_parser = strict
            result = LibXML::XML::Parser.string(xml).parse 
            return { result.root.name.to_s => xml_node_to_hash(result.root)} 
          rescue Exception => e
            raise $!
            # raise your custom exception here
          end
        end 

        def xml_node_to_hash(node) 
          # If we are at the root of the document, start the hash 
          if node.element? 
           if node.children? 
              result_hash = {} 

              node.each_child do |child| 
                result = xml_node_to_hash(child) 

                if child.name == "text"
                  if !child.next? and !child.prev?
                    return result
                  end
                elsif result_hash[child.name]
                    if result_hash[child.name].is_a?(Object::Array)
                      result_hash[child.name] << result
                    else
                      result_hash[child.name] = [result_hash[child.name]] << result
                    end
                  else 
                    result_hash[child.name] = result
                  end
                end

              return result_hash 
            else 
              return nil 
           end 
           else 
            return node.content.to_s 
          end 
        end          
    end
end
