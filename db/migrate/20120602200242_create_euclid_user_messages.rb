class CreateEuclidUserMessages < ActiveRecord::Migration
  def change
    create_table :euclid_user_messages do |t|
      t.integer :euclid_user_id
      t.integer :euclid_message_id
      t.string :note

      t.timestamps
    end
  end
end
