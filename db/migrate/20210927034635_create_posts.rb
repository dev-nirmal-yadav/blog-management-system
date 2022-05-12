# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :status, default: 0
      t.datetime :published_at
      t.integer :user_id, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
