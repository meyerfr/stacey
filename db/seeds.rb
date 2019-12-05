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
