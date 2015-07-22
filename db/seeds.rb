# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create movies.  Only really bad sequels permitted.
title_noun = ["The Biography of Nicholas Cage", "The Mummy", "Star Wars", "Pokemon", "Hello Kitty Island Adventure", "Sharknado"]
title_suffix_words = ["2 Furious", "The Reckoning", "The Kingdom Of The Crystal Skull", "With A Vengeance", "Die Another Day", "Resurrection", "Armed and Fabulous"]
title_country = %w[USA China Mexico Japan]
genres = %w[Action Comedy Drama Western]

50.times do |i|
  Movie.create(title: "#{title_noun.sample} #{Random.rand(1..5)}: #{title_suffix_words.sample}",
               info: Faker::Lorem.sentence(5),
               length: Random.rand(1800..10800),
               genre: genres.sample,
               year: Random.rand(1950..2015),
               country: title_country.sample,
               url: Faker::Internet.url)
end

# Create all possible flights given a set of airports, between 30m and 12h
airports = %w[ATL BOS DEN LAX MIA SFO SEA JFK]
routes = airports.permutation(2).map{ |i| i.join(' - ') }
routes.length.times do |i|
  Flight.create(route: routes[i], length: 1800 + Random.rand(23400))
end

# Create quiz with questions and answers
# genre assessment
q1_answer_content = ["Befriend the Dinosaurs", "Laugh with John Belushi",
  "Watch the tragic plays of Ancient Rome", "Live in the Wild West"]
q1 = Question.create(content: "You found a time machine!  What do you do?!")
4.times do |i|
  Answer.create(content: q1_answer_content[i], question_id: q1.id)
end

# country of origin assessment
q2_answer_content = %w[USA China Mexico Japan]
q2 = Question.create(content: "The plane is crash-landing!  Ahh!  What country
                              do you hope to find yourself in?")
4.times do |i|
  Answer.create(content: q2_answer_content[i], question_id: q2.id)
end

# movie length assessment
q3_answer_content = %w[short average long titanic]
q3 = Question.create(content: "How long do you like your movies?")
4.times do |i|
  Answer.create(content: q3_answer_content[i], question_id: q3.id)
end
