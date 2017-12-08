module RecordsDoc 
	extend Apipie::DSL::Concern
	# Apipie.app.set_resource_id(self, :records)
	# resource :records

	# def self.superclass
	# 	RecordsController
	# end

	# # I get an error here 
	 # Title doc
	# resource_description do
	# 	resource_id 'RecordsController'
	# 	short 'Create, Read, Update and Delete a Student'
	# 	formats ['json']
	# 	description <<-EOS
	# 	  Used to handle the data behind the scenes on the front end side. 
	# 	EOS
	# 	api_versions "1", "2"
	# end

	def_param_group :student do
		header 'X-CSRF-Token', 'Token to prevent against cross-site request forgery', required: true  
		param :name, String, desc: "Student name", required: true
		param :grade, Integer, desc: "Student grade (standard)", required: true
		param :roll, Integer, desc: "Student roll number", required: true
		param :id, String, desc: "Student record id (inside database)", required: true
		param :email, /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$/, desc: "email should fit the regex", required: true
		api_versions "1", "2"
	end

	api_versions "1", "2"
	# GET all students
	api! "Get all the students"
	formats ['json']
	description <<-EOS
		## Full description
			Gets all the student records from the database. 
	EOS
	def index
	end

	# GET the last added student
	api! "Get the last added student"
	formats ['json']
	description <<-EOS
		## Description
			*Get the last added student from the database. Used to retrieve the newest student.* 
	EOS
	api_version "2"
	def last
	# get last user
	end


	# POST a new student into students
	api! "Create a new student"
	param_group :student
	param :address, String, desc: "address of the student"
	description <<-EOS
		## Description
		Used for creating a new user. 

		**POST** the new info to **/students/:student_id/records**

		### Note
		When a new Student info is given, id is empty. This empty id is posted 

		along with the rest of the parameters to the server. Server database fills the id

		and the next time you query for this student record, it is returned with a proper id.

		----------------
	EOS

	example <<-EOS
		# Say,
		#	name = foo
		#	grade = 9
		#	roll = 8
		#	and student's id is 1
		
		Request URL: http://example.com/1/records
		Request method: POST

		## Request
		Host: example.com
		User-Agent: Mozilla/5.0 
		Accept: application/json, text/plain
		Accept-Language: en-US,en;q=0.5
		Accept-Encoding: gzip, deflate
		Referer: http://example.com/
		X-CSRF-Token: N7VTmGYUFHqw5OZzasSFQg/d1y2A69c30UnvBbLBxyP4+yCuddvSpgtUWiXu3bnIAy1wt3xOI19T2jxLn8D/dg==
		Content-Type: application/json;charset=utf-8
		Content-Length: 47
		Cookie: _example_session=Um9hbHJsN3J3TW91e...
		Connection: keep-alive

		## Request body
		{"name":"foo","grade":"9","roll":"8","id":{}}

		## Response
		{
			"id":"5a2a8e1e0e72df4f8414daa0",
			"grade":9,
			"name":"foo",
			"roll":8
		}
	EOS
	def create
	end


	# PUT new data in place of some old data in a student
	api! "Update the student info"
	description <<-EOS
		## Full description
			You can update a student using id.

			E.g., if student id = "5a1bdd440e72df0a2a5783a4"

			POST with updated data to htpp://www.example.com/id/5a1bdd440e72df0a2a5783a4

			Every student record will have its own unique hash id.

			Note: id comes from the database (MongoDB in this case) and varies for every record. 
	EOS
	param_group :student
	error code: 500, desc: "Internal server error", meta: { note: "probably something wrong with your code" }
	def update
	end

	# DELETE a student 
	api! "Delete a student"  
	description <<-EOS
		## Full description
			Send a DELETE request to /records/:id

			E.g., if student id = "5a1bdd440e72df0a2a5783a4"

			DELETE request will be sent to htpp://www.example.com/id/5a1bdd440e72df0a2a5783a4
	EOS
	param_group :student
	error code: 404, desc: "Not found"
	error code: 500, desc: "Internal server error"
	def destroy
	end
end