class RemoveKeywordFromUrls < ActiveRecord::Migration[5.0]
  def change
    remove_column :urls, :keyword, :string
  end
end
