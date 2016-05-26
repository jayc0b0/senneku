class AddClicktrackToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :track_clicks, :boolean
  end
end
