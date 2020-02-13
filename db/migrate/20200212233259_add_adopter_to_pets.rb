class AddAdopterToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :adopter, :integer
  end
end
