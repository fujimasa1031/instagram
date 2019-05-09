# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :caption
      t.references :user, forien_key: :true, null: false
      t.timestamps
    end
  end
end
