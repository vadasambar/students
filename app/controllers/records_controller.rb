class RecordsController < ApplicationController
  # skip_before_action :verify_authenticity_token 
  # include Apipie::Markup::Markdown
  include RecordsDoc


  # Title doc 
  resource_description do
    short 'Create, Read, Update and Delete a Student'
    formats ['json']
    description <<-EOS
      Used to handle the data behind the scenes on the front end side. 
    EOS
    api_versions "1", "2"
  end

  def index
    cleaned_json = clean_json Record.all 
    # this is built-in to_json method. It respects my as_json override from BSON::ObjectID
    # render json: Record.all 
    render json: cleaned_json
  end

  def last
    render json: Record.last # clean json and fix make json: pick up the overriden as_json of BSON::ObjectID
  end

  def create
    render json: Record.create(verify_params)
  end

  def update
   record =  Record.find_by(_id: verify_params[:id]) # get the student
   record.update(name: verify_params[:name]) 
   record.update(grade: verify_params[:grade])
   record.update(roll: verify_params[:roll])

   render json: {} # to return 200 OK instead of 204 
  end

  def destroy
    Record.find_by(id: verify_params[:id]).destroy
  end

  private

  # permit only the data which has all four fields filled.
  def verify_params
    # since I am passing id to the html page
    puts "PARAMS: " + params.to_s
    params.permit(:name, :grade, :roll, :id)
  end

  # records is a Criteria or Record object
  def clean_json records
   json_data = records.as_json # this is as_json method of Mongoid::Criteria class 

    if json_data.class == Array # if the json data is an array
      json_data.each do |row|
        row["id"] = row.delete "_id" # this is to make sure angular recognizes @id when sending requests
      end
    else
      json_data["id"] = json_data.delete "_id" # if the json_data is not an array
    end

    json_data
  end
end
