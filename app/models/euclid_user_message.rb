class EuclidUserMessage < ActiveRecord::Base
  belongs_to :euclid_message;
  belongs_to :euclid_user;
end
