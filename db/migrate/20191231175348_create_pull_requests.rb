class CreatePullRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :pull_requests do |t|
      t.integer :number
      t.string :creator
      t.string :merged_by 
      t.string :milestone
      t.timestamp :pr_created_at
      t.timestamp :pr_merged_at

      t.timestamps
    end
  end
end
