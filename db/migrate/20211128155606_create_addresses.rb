class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :student, null: false, foreign_key: true
      t.string :street, null: false
      t.string :number
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
