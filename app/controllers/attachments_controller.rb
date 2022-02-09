# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :find_attachment

  def destroy
    if current_user.author_of?(@attachment.record)
      @attachment.purge
      flash[:notice] = 'File deleted'
    end
  end

  private

  def find_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end
