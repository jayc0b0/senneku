class Upload < ActiveRecord::Base
  has_attached_file :upload

  validates_attachment_presence :upload
  do_not_validate_attachment_file_type :upload

  # Hash file for URL/path:
  # foo.bar/uploads/MD5/SHA256/ID
  before_save :hash_file

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
end
