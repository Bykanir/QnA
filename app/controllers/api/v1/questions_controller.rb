# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      before_action :find_question, only: %i[show update destroy]

      authorize_resource

      def index
        @questions = Question.all
        render json: @questions, each_serializer: QuestionsSerializer
      end

      def show
        render json: @question
      end

      def create
        @question = current_resource_owner.questions.new(question_params)
        if @question.save
          head :ok
        else
          render json: { errors: @question.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @question.update(question_params)
          head :ok
        else
          render json: { errors: @question.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @question.destroy
          head :ok
        else
          head :unprocessable_entity
        end
      end

      private

      def find_question
        @question = Question.find(params[:id])
      end

      def question_params
        params.require(:question).permit(:title, :body, links_attributes: %i[name url])
      end
    end
  end
end
