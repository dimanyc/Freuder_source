class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
    	t.integer :user_id
    	t.integer :message_id
    	t.string :name 
    	t.text :description
    	t.text :slips
      t.string :filtered_message_ids
      t.integer :slipped_count, default: 0
      t.timestamps
    end
  end
end
