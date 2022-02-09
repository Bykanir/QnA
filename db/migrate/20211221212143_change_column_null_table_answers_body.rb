# frozen_string_literal: true

class ChangeColumnNullTableAnswersBody < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:answers, :body, false)
  end
end
