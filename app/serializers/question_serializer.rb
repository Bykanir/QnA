# frozen_string_literal: true

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at

  has_many :comments
  has_many :links
  has_many :files, serializer: FilesSerializer
end
