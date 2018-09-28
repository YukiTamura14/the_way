class CreateConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :concerns do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
