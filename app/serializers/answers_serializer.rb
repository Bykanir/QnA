# frozen_string_literal: true

class AnswersSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at

  belongs_to :author
end
