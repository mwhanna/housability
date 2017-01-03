class Search < ActiveRecord::Base
	def add_search(address)
    self.search = address  
  end
end
