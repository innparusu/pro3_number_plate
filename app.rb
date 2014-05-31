require 'sinatra'
require 'active_record'

set :bind, '0.0.0.0'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'number_palate.sqlite3'
)

class Image < ActiveRecord::Base
end

get '/' do
    "Hello #{Image.count} images!"
end

post '/create' do
  image      = Image.new
  image.data = params[:upload_file]
  image.save
  puts params[:image]
  File.open("./image/#{@image.id}.jpg", "wb") do |file|
    file.write(@image.data)
  end
end

get '/:id/show' do
  @image_path = "./image/#{params[:id]}.jpg"
  erb :show
end
