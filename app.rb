require 'sinatra'
require 'active_record'
require 'tesseract-ocr'

set :bind, '0.0.0.0'

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
    File.open("./public/images/#{image.id}.jpg", "wb") do |file|    
      file.write(image.data)
    end
    
    system("pro3_ocr/cpp/a.out ./public/images/#{image.id}.jpg")

    engine = Tesseract::Engine.new do |engine|
        engine.language = :eng
    end

    txt = engine.text_for('pro3_ocr/cpp/Out.tif')
    image.number =  txt.split("\n")[1].gsub(/[^\d\-]/,"")[-4,4].sub(/\-/," ")
   image.save 
end

get '/:id/show' do
  @image_path = "./images/#{params[:id]}.jpg"
  erb :show
end
