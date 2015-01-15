class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text :body, unique: true, null: false
    	t.string :author, null: true
    	t.string :hashtags, null: true
    	t.string :author_image_url, null: true
    	t.string :replies, null: true
    	t.string :mentions, null: true
      t.string :urls, null: true
      t.string :slipped, null: true
    	t.references :messageable, polymorphic: true, index: true 
  	
      t.timestamps
    end
  end
end
