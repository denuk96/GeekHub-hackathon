class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource_or_scope)
    if resource.sign_in_count == 1
      root_path
    else
      root_path
    end
  end
end
