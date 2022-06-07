require 'faker'
Faker::Config.locale = 'en-GB'

UserActivity.delete_all
Match.delete_all
Activity.delete_all
User.delete_all

puts "start creating activities"
activities = ["crossfit","bodybuilding","tennis","climbing","boxing","swimming","golf","running"]
i = 0
while i < activities.length
  Activity.create(
  name: activities[i].to_s
  )
  i=i+1
end

activity = Activity.all

puts "start creating users"
10.times do
  start_time1 = rand(5..23).to_i
  end_time1 = start_time1.to_i + rand(1..4).to_i
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: Faker::Gender.binary_type.to_s,
    address: Faker::Address.postcode,
    age: rand(15..50).to_i,
    level_of_fitness: ["Beginner","Intermediate","Advanced"].sample.to_s,
    days_available: ["Monday","Tuesday","Wednesday", "Thursday","Friday","Saturday","Sunday"].sample(2),
    start_time: start_time1,
    end_time: end_time1.to_i,
    partner_gender_preference: ["Male","Female","Flexible"].sample,
    bio: ["Pain is temporary, pride is forever","Shut up and squat!","Forget the glass slippers, princess wear running shoes","Gym is my therapy.","Work. Train. Repeat.","Work hard now, selfie later.","Fit and Fat differ by middle alphabet.","I’m in a good place right now, not emotionally, I am just at the gym.","No pain, no gain. Shut up and train","Change your body by changing your thoughts.","Eat, sleep , gym , repeat." ].sample,
  )
end
user = User.all

puts "start creating user_activities"
40.times do
  UserActivity.create!(
    user_id: user.sample.id,
    activity_id: activity.sample.id
  )
end

puts "start creating matches"
20.times do
  users = User.all
  user_1 = users.sample
  user_2 = users.sample
  while user_2 == user_1
    user_2 = users.sample
  end
  Match.create!(
    user_requester_id: user_1.id,
    user_receiver_id: user_2.id
)
end
puts "finished"
