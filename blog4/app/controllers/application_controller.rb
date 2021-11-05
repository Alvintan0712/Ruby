class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        @current_user ||= User.find(session[:current_userid]) if session[:current_userid]
    end
end
