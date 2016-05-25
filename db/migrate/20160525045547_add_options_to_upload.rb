class AddOptionsToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :click_limit, :integer
    add_column :uploads, :click_count, :integer
    add_column :uploads, :delete_on, :datetime
    add_column :uploads, :delete_in, :integer
  end
end
