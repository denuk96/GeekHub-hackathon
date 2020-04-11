class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource_or_scope)
    if resource.sign_in_count == 1
      edit_user_category_path(id: 1)
    else
      root_path
    end
  end
end
