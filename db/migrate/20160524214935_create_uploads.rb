class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :filename

      t.timestamps null: false
    end
  end
end
