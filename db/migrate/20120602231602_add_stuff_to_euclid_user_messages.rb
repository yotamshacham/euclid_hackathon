class AddStuffToEuclidUserMessages < ActiveRecord::Migration
  def change
    add_column :euclid_user_messages, :detected, :integer

    add_column :euclid_user_messages, :close, :integer

  end
end
