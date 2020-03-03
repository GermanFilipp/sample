class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.belongs_to :video
      t.integer :attachment_type, default: 0, null: false
      t.string :file, null: false
      t.timestamps
    end
    add_index :attachments, [:video_id, :attachment_type], unique: true
  end
end
