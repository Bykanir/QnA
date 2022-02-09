# frozen_string_literal: true

class AddForeignKeyForUserAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference(:answers, :author, null: false, foreign_key: { to_table: :users })
  end
end
