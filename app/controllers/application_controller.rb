class ApplicationController < ActionController::Base
  def reload
    redirect_to(request.referrer || root_path)
  end
end
