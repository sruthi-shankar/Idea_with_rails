# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.delete_all()
Idea.delete_all()
User.delete_all()


NUM_OF_IDEAS=80
NUM_OF_USERS=100
PASSWORD = 'supersecret'

super_user = User.create(
    first_name: "Jon",
    last_name: "Snow",
    email: "js@winterfell.gov",
    password: PASSWORD, 
    is_admin: true
)


NUM_OF_USERS.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
        password: PASSWORD
    )
end
users=User.all

NUM_OF_IDEAS.times do
    created_at = Faker::Date.backward(days: 365)
    i = Idea.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        created_at: created_at, 
        updated_at: created_at,
       # view_count: Faker::Number.between(from: 1, to: 100),
        user: users.sample
    )
    if i.valid?
        i.reviews = rand(0..15).times.map do 
            Review.new(
                body: Faker::GreekPhilosophers.quote,
                user: users.sample
            )
        end
    end
end

ideas=Idea.all
reviews=Review.all


puts Cowsay.say("Generated #{reviews.count} users", :stegosaurus)
puts Cowsay.say("Generated #{ideas.count} ideas", :sheep)
puts Cowsay.say("Generated #{users.count} reviews", :tux)
