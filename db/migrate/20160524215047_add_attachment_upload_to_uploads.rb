class AddAttachmentUploadToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :uploads, :upload
  end
end
