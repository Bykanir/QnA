# frozen_string_literal: true

class AddColumnBestAnswerForAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :best, :boolean, default: false
  end
end
