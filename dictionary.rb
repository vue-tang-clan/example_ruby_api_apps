require "unirest"

while true
  system "clear"
  puts "Welcome to the Dictionary App!"

  print "Enter a word: "
  input_word = gets.chomp

  response = Unirest.get("https://api.wordnik.com/v4/word.json/#{input_word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=#{ENV['WORDNIK_API_KEY']}")
  definitions = response.body

  # puts JSON.pretty_generate(definitions)

  puts "The definition of #{input_word} is:"
  puts definitions[0]["text"]
  puts

  response = Unirest.get("http://api.wordnik.com:80/v4/word.json/#{input_word}/topExample?useCanonical=false&api_key=#{ENV['WORDNIK_API_KEY']}")
  top_example = response.body["text"]

  # puts JSON.pretty_generate(response.body)

  puts "An example using the word"
  puts top_example
  puts

  response = Unirest.get("http://api.wordnik.com:80/v4/word.json/#{input_word}/pronunciations?useCanonical=false&limit=50&api_key=#{ENV['WORDNIK_API_KEY']}")
  pronunciations = response.body

  # puts JSON.pretty_generate(pronunciations)

  puts "Here is the pronunciation for the word:"
  puts pronunciations[0]["raw"]
  puts

  puts "Enter q to quit, or any other key to continue"
  input_choice = gets.chomp
  if input_choice == "q"
    puts "Thank you, goodbye!"
    break
  end
end
