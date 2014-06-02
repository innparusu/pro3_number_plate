require 'tesseract-ocr'

engine = Tesseract::Engine.new do |engine|
    engine.language = :eng
end

txt = engine.text_for('../cpp/Out.tif')
#puts engine.text_for('../cpp/Out.tif')

#puts txt.gsub(/[^\d\-]/,"")[-4,4]
puts txt.split("\n")[1].gsub(/[^\d\-]/,"")[-4,4].sub(/\-/," ")
