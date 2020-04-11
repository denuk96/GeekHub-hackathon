class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user, :category)
  end

  def show
    @post = Post.includes(:user, :category).find params[:id]
  end

  def user_posts
    @posts = Post.includes(:user).where(users: { id: current_user.id }).includes(:category)
    render "posts/index"
  end

  def posts_with_included_categories
    categories = current_user.categories.includes(posts: :user)
    @posts = []
    categories.each do |category|
      @posts +=category.posts
    end

    render "posts/index"
  end

  def render_form
    render 'posts/form'
  end

  def parse_link
    row_link = params[:body][:link]
    user = current_user

    result = PostFabric::Parse.new(row_link, user).generate_post

    if result == 'Success'
      redirect_to root_path, notice: 'Success'
    else
      render 'posts/form', alert: 'Error'
    end
  end
end
