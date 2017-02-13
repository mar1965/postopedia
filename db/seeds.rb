require 'faker'

# Create Users
5.times do
  User.create!(
      #name:     RandomData.random_name,
      email:    Faker::Internet.email,
      password: Faker::Internet.password(8)
  )
end
users = User.all

# Create Wikis
25.times do
  Wiki.create!(
    title: Faker::Hipster.sentence(3, true, 4),
    body: Faker::Hipster.paragraph(2, true, 4),
    private: Faker::Number.between(0, 2),
    user: users.sample
  )
end
wikis = Wiki.all

puts "Finished seeding"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
