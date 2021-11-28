class CreateDisciplines < ActiveRecord::Migration[6.1]
  def change
    create_table :disciplines do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
