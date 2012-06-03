# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

EuclidMessage.delete_all
EuclidMessage.create(:title=>"GAP 15% Coupon", :body=>"Welcome to GAP! Click on the link below to get 15% off your entire purchase.\n\n%link%");

EuclidUser.delete_all
EuclidUser.create(:name=>'Yotam', :mac_addr => '00254B51CD6B', :sms => '+16508046557', :note => "Yotam's Phone", :proximity => 'distant');
EuclidUser.create(:name=>'Shely', :mac_addr => '148FC600472A', :sms => '+17347303047', :note => "Shely's Phone", :proximity => 'distant');

EuclidUserMessage.delete_all
