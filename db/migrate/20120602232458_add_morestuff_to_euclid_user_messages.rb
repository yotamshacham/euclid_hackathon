class AddMorestuffToEuclidUserMessages < ActiveRecord::Migration
  def change
    add_column :euclid_user_messages, :linkpressed, :integer

    add_column :euclid_user_messages, :purchased, :integer

  end
end
