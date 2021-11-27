class CreateReferencesQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :answers, index: true, foreign_key: true
    add_reference :answers, :question, index: true, foreign_key: true
  end
end
