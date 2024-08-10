class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :product
      t.integer :cost

      t.timestamps
    end
  end
end
