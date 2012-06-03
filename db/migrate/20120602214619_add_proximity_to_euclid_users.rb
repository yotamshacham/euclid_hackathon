class AddProximityToEuclidUsers < ActiveRecord::Migration
  def change
    add_column :euclid_users, :proximity, :string

  end
end
