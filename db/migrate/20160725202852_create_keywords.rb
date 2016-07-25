class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.text :cache
      t.string :processed_at
      t.integer :total_results
      t.float :search_time

      t.timestamps
    end
  end
end
