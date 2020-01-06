# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# print('create User')
# User.create!(
#   first_name: 'Fritz',
#   last_name: 'Meyer',
#   email: 'fritz@stacey-living.de',
#   role: 'admin',
#   dob: '2000-02-04',
#   city: 'Düsseldorf',
#   country: 'Germany',
#   street: 'Weezer Straße 6',
#   zipcode: 40547,
#   # move_in: '2020-01-01',
#   # move_out: '2020-04-01',
#   job: 'Developer',
#   gender: ['male'],
#   phone_number: '01737557722',
#   phone_code: '+49',
#   password: 'FritzMeyer',
#   prefered_suite: ['Basic']
# )

print('create Admins')
fritz = User.create(first_name: 'Fritz', last_name: 'Meyer', email: 'fritz@stacey-living.de', password: 'FritzMeyer', role: 'Admin', dob: '2000-04-02', job: 'Developer', gender: ['Male'], phone_code: '+49', phone: '01737557722')
matteo = User.create(first_name: 'Matteo', last_name: 'Kreidler', email: 'matteo@stacey-living.de', password: 'MatteoKreidler', role: 'Admin', dob: '1996-08-26', job: 'CEO', gender: ['Male'], phone_code: '+49', phone: '015234514111')

print('create Bookings')
fritz_booking = Booking.create(user_id: fritz.id, move_in: Date.tomorrow, move_out: Date.tomorrow + 3.months)
matteo_booking = Booking.create(user_id: matteo.id, move_in: Date.tomorrow, move_out: Date.tomorrow + 3.months)

print('create WelcomeCalls')
WelcomeCall.create(start_time: Time.parse('2020-01-09 5:30pm'), end_time: Time.parse('2020-01-09 5:45pm'), available: false, booking_id: fritz_booking)
WelcomeCall.create(start_time: Time.parse('2020-01-09 5:00pm'), end_time: Time.parse('2020-01-09 5:15pm'), available: false, booking_id: matteo_booking)

# print('create Amenities')
# wifi = Amenity.create(title: 'High Speed Wifi')
# speakers = Amenity.create(title: 'Speakers')
# furnished = Amenity.create(title: 'Furnished')
# netflix = Amenity.create(title: 'Netflix')
# work_space = Amenity.create(title: 'Work Spaces')
# tabletennis = Amenity.create(title: 'Tabletennis')
# communal_kitchen = Amenity.create(title: 'Communal Kitchen')
# smart_lock = Amenity.create(title: 'Smart Lock')
# weekly_cleaning = Amenity.create(title: 'Weekly Cleaning')
# queen_size_bed = Amenity.create(title: 'Queen Size Bed')
# one_person = Amenity.create(title: 'One Person')
# two_people = Amenity.create(title: 'Two People')

# print('create Icons')
# Icon.create(amenity_id: wifi.id, icon_text: '<i class="fas fa-wifi"></i>')
# Icon.create(amenity_id: speakers.id, icon_text: '<i class="fas fa-volume-up"></i>')
# Icon.create(amenity_id: furnished.id, icon_text: '<i class="fas fa-couch"></i>')
# Icon.create(amenity_id: netflix.id, icon_text: '<i class="fas fa-tv"></i>')
# Icon.create(amenity_id: work_space.id, icon_text: '<i class="fas fa-briefcase"></i>')
# Icon.create(amenity_id: tabletennis.id, icon_text: '<i class="fas fa-table-tennis"></i>')
# Icon.create(amenity_id: communal_kitchen.id, icon_text: '<i class="fas fa-utensils"></i>')
# Icon.create(amenity_id: weekly_cleaning.id, icon_text: '<i class="fas fa-broom"></i>')
# Icon.create(amenity_id: smart_lock.id, icon_text: '<i class="fas fa-lock-open"></i>')
# Icon.create(amenity_id: queen_size_bed.id, icon_text: '<i class="fas fa-bed"></i>')
# Icon.create(amenity_id: one_person.id, icon_text: '<i class="fas fa-user"></i>')
# Icon.create(amenity_id: two_people.id, icon_text: '<i class="fas fa-user-friends"></i>')


# print('create Project')
# muehlenkamp = Project.create(name: 'Mühlenkamp', street: 'Dorotheen Straße', house_number: '5-7', city: 'Hamburg', zipcode: 12345, description: 'At  STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\r\nFrom the great living room and the shared kitchen to our beautiful terrace with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!', pictures: ['https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4061_location_muehlenkamp.jpg', 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4077_location_muehlenkamp.jpg', 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075659/M%C3%BChlenkamp/IMG_4068_location_muehlenkamp.jpg'])

# print('create Rooms')
# Room.create(project_id: muehlenkamp.id, number: '1', house_number: '5', price: [900, 850, 800], name: 'Mighty', size: 15.5, description: 'Scandinavian minimalism in the heart of Hamburg. Our Mighty Suites are our flagship with regard to modern living. A comfy double bed, side table, armchair, floor lamp, closet, hangers, artwork & even bedding are included.', pictures: ['https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075783/M%C3%BChlenkamp/Mighty/IMG_4015_mighty.jpg', 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4021_mighty.jpg', 'https://res.cloudinary.com/dvuqwvjay/image/upload/v1576075782/M%C3%BChlenkamp/Mighty/IMG_4016_mighty.jpg'])
