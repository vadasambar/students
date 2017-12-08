class StudentsController < ApplicationController
  # default page. my front page

  resource_description do 
  	short 'Front end web interface'
  	description <<-EOS 
  		This is the main page that user sees and interacts with. 
  	EOS
  	api_versions "1", "2"
  end
  include StudentsDoc

  def index
  end
end
