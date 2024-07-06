class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :address
      t.string :image

      t.timestamps
    end
  end
end
