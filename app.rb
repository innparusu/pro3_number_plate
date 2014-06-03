require 'sinatra'
require 'active_record'
require 'tesseract-ocr'
require 'json'

set :server, 'webrick'
set :bind, '0.0.0.0'
set :environment, :production

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'number_palate.sqlite3'
)

class Image < ActiveRecord::Base
end

get '/' do
  "Hello #{Image.count} images!"
  @images = Image.all
  erb :index
end

post '/create' do
  image      = Image.new
  image.data = params[:upload_file]
  if image.save 
    File.open("./public/images/#{image.id}.jpg", "wb") do |file|
      file.write(params[:upload_file])
    end
  end
  
  system("./pro3_ocr/cpp/a.out ./public/images/#{image.id}.jpg")

  engine = Tesseract::Engine.new do |engine|
    engine.language = :eng
  end

  txt = engine.text_for('./Out.tif')
  puts "---------"
  puts txt
  puts "---------"
  puts "---------"
  puts txt.split("\n")[1].gsub(/[^\d\-]/,"")
  puts "---------"
  image.number =  txt.split("\n")[1].gsub(/[^\d]/,"")

  image.save 

  content_type :json
  image.number.to_json
end

get '/:id/show' do
  @image_path = "./images/#{params[:id]}.jpg"
  erb :show
end
