class CreateSlips < ActiveRecord::Migration
  def change
    create_table :slips do |t|
    	t.integer :filter_id
    	t.string :slip

      t.timestamps
    end
  end
end
