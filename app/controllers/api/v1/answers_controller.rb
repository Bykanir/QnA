# frozen_string_literal: true

module Api
  module V1
    class AnswersController < Api::V1::BaseController
      before_action :find_answer, only: %i[show update destroy]
      before_action :find_question, only: [:create]

      authorize_resource

      def index
        @answers = Answer.all
        render json: @answers, each_serializer: AnswersSerializer
      end

      def show
        render json: @answer
      end

      def create
        @answer = @question.answers.new(answer_params)
        @answer.author = current_resource_owner

        if @answer.save
          head :ok
        else
          render json: { errors: @answer.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @answer.update(answer_params)
          head :ok
        else
          render json: { errors: @answer.errors }, status: :unprocessable_entity

        end
      end

      def destroy
        if @answer.destroy
          head :ok
        else
          head :unprocessable_entity
        end
      end

      private

      def find_answer
        @answer = Answer.find(params[:id])
      end

      def answer_params
        params.require(:answer).permit(:body, links_attributes: %i[name url])
      end

      def find_question
        @question ||= Question.find(params[:question_id])
      end
    end
  end
end
