class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.text :content
      t.string :image, default: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg"

      t.timestamps
    end
  end
end
