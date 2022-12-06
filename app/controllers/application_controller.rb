class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def client
    @client ||= Hackernews::Client.new
  end
end
