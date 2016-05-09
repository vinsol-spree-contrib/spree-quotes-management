class CreateQuotes < ActiveRecord::Migration

  def change
    create_table :spree_quotes do |t|
      t.text :description
      t.integer :rank
      t.string :state
      t.belongs_to :user
      t.string :author_name

      t.timestamps null: false
    end
  end

end
