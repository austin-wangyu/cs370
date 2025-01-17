class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :course
      t.decimal :meeting_length
      t.string :subject
      t.string :status, default: "open" #options: open, matched, closed by admin
      t.json :meta_values
      t.timestamps
    end
  end
end
