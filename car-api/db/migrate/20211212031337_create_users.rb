# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nickname, index: { unique: true }
      t.string :email, index: { unique: true }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
