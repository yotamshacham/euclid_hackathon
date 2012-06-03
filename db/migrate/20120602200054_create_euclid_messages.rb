class CreateEuclidMessages < ActiveRecord::Migration
  def change
    create_table :euclid_messages do |t|
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
