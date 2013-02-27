class AddCallnumberRanges < ActiveRecord::Migration
  def change
    create_table :maps_call_number_ranges do | t |
      t.string :begin_call_number
      t.string :end_call_number
      t.integer :map_file_id
    end

    add_index :maps_call_number_ranges, [ :begin_call_number, :end_call_number ], :name => 'maps_call_number_ranges_index'
    add_index :maps_call_number_ranges, :map_file_id
  end
end
