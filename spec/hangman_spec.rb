require 'hangman.rb'

describe ImportDictionary do
  it "should import the local dictionary file /'5desk.txt/'"
  id = ImportDictionary.new
  expect(id).to respond_to(:to_s)
end
