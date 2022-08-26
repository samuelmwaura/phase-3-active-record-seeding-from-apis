# Add seed data in this file
puts "Carrying out database seeding..."  #show seeding begin

spells = ["acid-arrow", "animal-messenger", "calm-emotions", "charm-person"] #an array of spells which we only have the name but we want to persist them to db with their other attributes

spells.each do |spell| #for each of our spells we fetch its details from the API endpoint
    response = RestClient.get("https://www.dnd5eapi.co/api/spells/#{spell}") #Rest client does the fetch from the endpoint just like the fetch API in js

    spell_hash = JSON.parse(response) #parse the Json string returned to a normal ruby hash and it is syncronous

    Spell.create(  #remember our Spell class is our link to our spells table in db. we use the create Orm method to create instances in to the db
        name: spell_hash["name"], #accessing the properties like a normal array
        level: spell_hash["level"],
        description: spell_hash["desc"][0]  #accessing the first element of the array
    )
end

puts "seeded the database with Sample data"  # show seeding complete

#Just needs you to know how to hit API endpoints