class RemoveFilenameFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :filename
  end
end
