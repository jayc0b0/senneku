class Upload < ActiveRecord::Base
  has_attached_file :upload,
    :url => "/system/:class/:attachment/:md5_hash/:sha256_hash/:filename",
    :path => ":rails_root/public/system/:class/:attachment/:md5_hash/:sha256_hash/:filename"

  # Hash file for URL/path:
  # foo.bar/uploads/MD5/SHA256/ID
  before_create :hash_file

  validates_attachment_presence :upload
  do_not_validate_attachment_file_type :upload

  private

  # Hash file
  def hash_file
    file = self.upload.queued_for_write[:original].path
    puts "\n#{file}"
    java_hash_class = "hash"
    Dir::chdir("lib/") do
      puts "MD5 HASH"
      self.md5_hash = %x{java #{java_hash_class} #{file} 1}
      puts "#{self.md5_hash}"
      puts "SHA256 HASH"
      self.sha256_hash = %x{java #{java_hash_class} #{file} 2}
      puts "#{self.sha256_hash}"
    end
  end

  # Interpolations
  Paperclip.interpolates :md5_hash do |attachment, style|
    attachment.instance.md5_hash
  end

  Paperclip.interpolates :sha256_hash do |attachment, style|
    attachment.instance.sha256_hash
  end
end
