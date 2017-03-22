full_dictionary = File.read('5desk.txt')
full_dictionary.scan(/\w+/)
full_dictionary.delete([A-Z])



puts full_dictionary
