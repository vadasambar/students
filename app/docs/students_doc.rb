module StudentsDoc
	extend Apipie::DSL::Concern

  	api_versions "1", "2"
  	api :GET, '/', 'Main(only) page'
  	formats ['html']
  	description <<-EOS
  	  	## Full description
	  	  	Used to show the front/main page that a user interacts with. 

	  	  	This is the page that a user is exposed to.
  	EOS
  	def index
  	end
end