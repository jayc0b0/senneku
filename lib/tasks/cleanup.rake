namespace :cleanup do
  desc "Deletes records for expired files"
  task expired_files: :environment do
    Upload.delete_all ["delete_on < ?", DateTime.now]
  end

  desc "Deletes records for files that have hit their click limit"
  task click_limits: :environment do
    Upload.delete_all ["click_count >= click_limit"]
  end

end
