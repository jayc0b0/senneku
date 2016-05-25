class Upload < ActiveRecord::Base
  has_attached_file :upload

  validates_attachment_presence :upload
  do_not_validate_attachment_file_type :upload
end
