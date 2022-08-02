# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :find_link

  authorize_resource

  def destroy
    if current_user.author_of?(@link.linkable)
      @link.destroy
      flash[:notice] = 'Your link successfully deleted.'
    end
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end
end
