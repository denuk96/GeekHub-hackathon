class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def user_posts
    @posts = Post.includes(:user).where(user: { id: current_user.id })
  end

  def render_form
    render "posts/form"
  end

  def parse_link
    row_link = params[:body][:link]
    user = current_user

    PostFabric::Parse.new(row_link, user).generate_post

    # byebug
    # p 'asdasd'
  end
end
