require 'random_data'

50.times do
  Wiki.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
wikis = Wiki.all

puts "Finished seeding"
puts "#{{Wiki.count}} wikis created"
