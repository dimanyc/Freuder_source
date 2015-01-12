class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :user_id
    	t.text :body
    	t.string :author
  	
      t.timestamps
    end
  end
end
