class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :author_id
      t.string :name
      t.timestamps null: false
    end
  end
end
