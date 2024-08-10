class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.integer :visitor_id
      t.integer :revenue
      t.integer :profit

      t.timestamps
    end
  end
end
