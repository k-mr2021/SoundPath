class CreatePostMusics < ActiveRecord::Migration[6.1]
  def change
    create_table :post_musics do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body
      t.string :file, null: false
      
      t.timestamps
    end
  end
end



