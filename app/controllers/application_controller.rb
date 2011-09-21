class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :determine_layout
  
  private
    def determine_layout
      'library'
    end
end
