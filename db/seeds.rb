# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#populate with fake matches
Match.create(user1Id: 2, user2Id: nil, status: "pending", wednesdayStartTime: 0, wednesdayEndTime: 300)
Match.create(user1Id: 3, user2Id: nil, status: "pending", tuesdayStartTime: 0, tuesdayEndTime: 300)
Match.create(user1Id: 4, user2Id: nil, status: "pending", tuesdayStartTime: 0, tuesdayEndTime: 300)
Match.create(user1Id: 5, user2Id: nil, status: "pending", tuesdayStartTime: 0, tuesdayEndTime: 300)
Match.create(user1Id: 6, user2Id: nil, status: "pending", fridayStartTime: 0, fridayEndTime: 300)
MatchToFood.create(matchId: 1, foodId: 2);
MatchToFood.create(matchId: 2, foodId: 2);
MatchToFood.create(matchId: 3, foodId: 2);
MatchToFood.create(matchId: 4, foodId: 4);
MatchToFood.create(matchId: 5, foodId: 4);

#populate food table
Food.create :name => "American"
Food.create :name => "Chinese"
Food.create :name => "Mexican"
Food.create :name => "Italian"
Food.create :name => "Japanese"
Food.create :name => "Greek"
Food.create :name => "French"
Food.create :name => "Thai"
Food.create :name => "Spanish"
Food.create :name => "Indian"
Food.create :name => "Mediterranean"
Food.create :name => "Korean"
Food.create :name => "Vietnamese"