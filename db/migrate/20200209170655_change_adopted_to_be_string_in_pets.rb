class ChangeAdoptedToBeStringInPets < ActiveRecord::Migration[5.1]

  def up
    change_column :pets, :adopted?, :string, :default => "Adoptable"
  end

  def down
    change_column :pets, :adopted?, :boolean => true
  end

end
