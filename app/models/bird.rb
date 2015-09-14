class Bird
 include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: Date, default: Time.now.to_date
  field :visible, type: Boolean, default: false

  validates_presence_of :name, :family, :continents
  validates_uniqueness_of :name


  def get_bird_response(param)
  	bird = {
	  "$schema"=> "http=>//json-schema.org/draft-04/schema#",
	  "title"=> "#{param} /birds [request]",
	  "description"=> param == "GET" ? "Get bird by id" : "Added new bird to the library",
	  "type"=> self.class.name,
	  "required"=> [
	   "id" => self.id.to_s,
	    "name" => self.name,
	    "family" => self.family,
	    "continents" => self.continents,
	    "added" => self.added.strftime("%d-%m-%Y"),
	    "visible" => self.visible
	  ],
	  "additionalProperties"=> false,
	  "properties"=> {
	    "id"=> {
	      "type"=> "string",
	      "description"=> "Object id from the database"
	    },
	    "name"=> {
	      "type"=> "string",
	      "description"=> "English bird name"
	    },
	    "family"=> {
	      "type"=> "string",
	      "description"=> "Latin bird family name"
	    },
	    "continents"=> {
	      "type"=> "array",
	      "description"=> "Continents the bird exist on",
	      "minItems"=> 1,
	      "items"=> { "type"=> "string" },
	      "uniqueItems"=> true
	    },
	    "added"=> {
	      "type"=> "string",
	      "description"=> "Date the bird was added to the registry. Format YYYY-MM-DD"
	    },
	    "visible"=> {
	      "type"=> "boolean",
	      "description"=> "Determines if the bird should be visible in lists"
	    }
	  }
	}

  end

  def get_bird_

  end
end
