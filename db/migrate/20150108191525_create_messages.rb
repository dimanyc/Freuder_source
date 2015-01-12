class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text :body, unique: true
    	t.string :author
    	t.references :messageable, polymorphic: true, index: true 
  	
      t.timestamps
    end
  end
end
