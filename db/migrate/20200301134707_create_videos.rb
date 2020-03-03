class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.integer :start_time, null: false
      t.integer :end_time, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end

    add_reference :videos, :user, foreign_key: true
  end
end
