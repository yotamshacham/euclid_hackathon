class CreateEuclidUsers < ActiveRecord::Migration
  def change
    create_table :euclid_users do |t|
      t.string :name
      t.string :mac_addr
      t.string :sms
      t.string :note

      t.timestamps
    end
  end
end
