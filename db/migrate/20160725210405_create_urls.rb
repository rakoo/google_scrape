class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.string :keyword
      t.string :url
      t.boolean :isTopAd
      t.boolean :isRightAd

      t.timestamps
    end
  end
end
