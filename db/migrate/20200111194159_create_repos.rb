# frozen_string_literal: true

class CreateRepos < ActiveRecord::Migration[6.0]
  def change
    create_table :repos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :full_name
      t.boolean :public
      t.text :data
      t.datetime :checked_at
      t.timestamps
    end
  end
end
