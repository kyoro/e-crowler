class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.string    :hashkey
      t.timestamps
    end
  end
end
