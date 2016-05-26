class AddHashesToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :md5_hash, :string
    add_column :uploads, :sha256_hash, :string
  end
end
