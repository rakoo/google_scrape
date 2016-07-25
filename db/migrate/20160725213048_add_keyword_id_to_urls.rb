class AddKeywordIdToUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :urls, :keyword_id, :integer
  end
end
