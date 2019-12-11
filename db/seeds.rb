# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(first_name: 'Fritz', last_name: 'Meyer', email: 'fritz@stacey-living.de', role: 'admin', dob: '2000-02-04', city: 'Düsseldorf', country: 'Germany', street: 'Weezer Straße 6', zipcode: 40547, move_in: '2020-01-01', move_out: '2020-04-01', job: 'Developer', gender: 'male', phone_number: '01737557722', phone_code: '+49')
WelcomeCall.create(start_time: Time.parse('2019-12-12 2pm'), end_time: Time.parse('2019-12-12 2:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-14 3pm'), end_time: Time.parse('2019-12-14 3:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-15 4pm'), end_time: Time.parse('2019-12-15 4:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-11 5pm'), end_time: Time.parse('2019-12-11 5:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-10 6pm'), end_time: Time.parse('2019-12-10 6:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-10 6:30pm'), end_time: Time.parse('2019-12-10 6:45pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-10 7:00pm'), end_time: Time.parse('2019-12-10 7:15pm'))

wifi = Amenity.create(title: 'High Speed Wifi')
speakers = Amenity.create(title: 'Speakers')
furnished = Amenity.create(title: 'Furnished')
netflix = Amenity.create(title: 'Netflix')
work_space = Amenity.create(title: 'Work Spaces')
tabletennis = Amenity.create(title: 'Tabletennis')
communal_kitchen = Amenity.create(title: 'Communal Kitchen')
smart_lock = Amenity.create(title: 'Smart Lock')
weekly_cleaning = Amenity.create(title: 'Weekly Cleaning')
queen_size_bed = Amenity.create(title: 'Queen Size Bed')
one_person = Amenity.create(title: 'One Person')
two_people = Amenity.create(title: 'Two People')

Icon.create(amenity_id: wifi.id, icon_text: '<i class="fas fa-wifi"></i>')
Icon.create(amenity_id: speakers.id, icon_text: '<i class="fas fa-volume-up"></i>')
Icon.create(amenity_id: furnished.id, icon_text: '<i class="fas fa-couch"></i>')
Icon.create(amenity_id: netflix.id, icon_text: '<i class="fas fa-tv"></i>')
Icon.create(amenity_id: work_space.id, icon_text: '<i class="fas fa-briefcase"></i>')
Icon.create(amenity_id: tabletennis.id, icon_text: '<i class="fas fa-table-tennis"></i>')
Icon.create(amenity_id: communal_kitchen.id, icon_text: '<i class="fas fa-utensils"></i>')
Icon.create(amenity_id: weekly_cleaning.id, icon_text: '<i class="fas fa-broom"></i>')
Icon.create(amenity_id: smart_lock.id, icon_text: '<i class="fas fa-lock-open"></i>')
Icon.create(amenity_id: queen_size_bed.id, icon_text: '<i class="fas fa-bed"></i>')
Icon.create(amenity_id: one_person.id, icon_text: '<i class="fas fa-user"></i>')
Icon.create(amenity_id: two_people.id, icon_text: '<i class="fas fa-user-friends"></i>')








