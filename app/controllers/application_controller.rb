class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, ActionView::MissingTemplate do
    redirect_to root_url
  end
end
