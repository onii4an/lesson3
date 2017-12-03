class SearchController < ApplicationController
  before_action lambda { @body_class = 'chat-page' }

  def show
  end

  private

  def chat_messages
    Message.search(params[:q])
  end
  helper_method :chat_messages

  def search_query
    params[:q]
  end
  helper_method :search_query

end
