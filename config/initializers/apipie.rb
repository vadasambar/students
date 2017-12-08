Apipie.configure do |config|
  config.app_name                = "Student"
  config.api_base_url            = "/" # root url
  config.doc_base_url            = "/apipie"

  config.app_info                = "Students REST API"
  # used to fix Resource not found issue
  config.translate 				 = false 
  # config.reload_controllers      = true 
  # where is your API defined?
  config.markup					 = Apipie::Markup::Markdown.new
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
