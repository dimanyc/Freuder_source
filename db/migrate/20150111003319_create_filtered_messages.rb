class CreateFilteredMessages < ActiveRecord::Migration
  def change
    create_table :filtered_messages do |t|
    	t.integer :filter_id
    	t.text :body
    	t.string :author    	
      t.timestamps
    end
  end
end
