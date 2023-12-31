class PostsController < ApplicationController
  before_action :check_user
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @user = current_user
    @posts = Post.all
    @posts = @posts.where(published: true).or(current_user.posts)
    respond_to do |format|
      @posts = Post.all
      format.html
      format.csv do
        filename = ['Posts', Date.today.to_s].join(' ')
        send_data Post.to_csv(@posts), filename:, content_type: 'text/csv'
      end
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=posts.xlsx"
      }
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @user = current_user
  end

  # GET /posts/1/edit
  def edit
    @user = current_user
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_user
    if(current_user.has_role? :inactive)
      flash[:alert] = "User Inactive"
      redirect_to page_index_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :image, :published)
    end
end
