module BirdsHelper

	def get_birds_response(birds)

		res = {
		  "$schema" => "http=>//json-schema.org/draft-04/schema#",
		  "title" => "GET /birds [request]",
		  "description" => "List all visible birds in the registry",
		  "type" => "array",
		  "additionalProperties" => false,
		}
		birds.each do |bird|
		res.merge("items" => {
		    "type" => "string",		   
		    "description" => bird.id.to_s,			
		    "uniqueItems" => true})
  		end
	end
end
