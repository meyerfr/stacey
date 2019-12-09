# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

WelcomeCall.create(start_time: Time.parse('2019-12-05 2pm'), end_time: Time.parse('2019-12-05 2:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-05 3pm'), end_time: Time.parse('2019-12-05 3:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-05 4pm'), end_time: Time.parse('2019-12-05 4:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-05 5pm'), end_time: Time.parse('2019-12-05 5:15pm'))
WelcomeCall.create(start_time: Time.parse('2019-12-05 6pm'), end_time: Time.parse('2019-12-05 6:15pm'))

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

Icon.create(amenity: wiki.id, icon_text: '<i class="fas fa-wifi"></i>')
Icon.create(amenity: speakers.id, icon_text: '<i class="fas fa-volume-up"></i>')
Icon.create(amenity: furnished.id, icon_text: '<i class="fas fa-couch"></i>')
Icon.create(amenity: netflix.id, icon_text: '<i class="fas fa-tv"></i>')
Icon.create(amenity: work_space.id, icon_text: '<i class="fas fa-briefcase"></i>')
Icon.create(amenity: tabletennis.id, icon_text: '<i class="fas fa-table-tennis"></i>')
Icon.create(amenity: communal_kitchen.id, icon_text: '<i class="fas fa-utensils"></i>')
Icon.create(amenity: weekly_cleaning.id, icon_text: '<i class="fas fa-broom"></i>')
Icon.create(amenity: smart_lock.id, icon_text: '<i class="fas fa-lock-open"></i>')
Icon.create(amenity: queen_size_bed.id, icon_text: '<i class="fas fa-bed"></i>')
Icon.create(amenity: one_person.id, icon_text: '<i class="fas fa-user"></i>')
Icon.create(amenity: two_people.id, icon_text: '<i class="fas fa-user-friends"></i>')








