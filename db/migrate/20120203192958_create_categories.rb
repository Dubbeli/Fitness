class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :categories
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :categories, :categories_id
  end
end
