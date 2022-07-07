class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_resource, only: [:create]

  def create
    @comment = @resource.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
  end

  private

  def find_resource
    klass = [Question, Answer].detect { |klass| params["#{klass.name.underscore}_id"]}
    @resource = klass.find(params["#{klass.name.underscore}_id"])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
