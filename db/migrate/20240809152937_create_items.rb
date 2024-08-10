class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :product
      t.integer :cost
      t.integer :sale_id

      t.timestamps
    end
  end
end
