class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :netid
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.cas_authenticatable
      t.trackable
      t.timestamps
    end
  end
end
