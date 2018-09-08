class CreateConcerns < ActiveRecord::Migration[5.2]
  def change
    create_table :concerns do |t|
      t.string :title
      t.text :content
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
