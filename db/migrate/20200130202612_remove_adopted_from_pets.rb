class RemoveAdoptedFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :adopted, :string
  end
end
