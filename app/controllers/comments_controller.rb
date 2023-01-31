class CommentsController < ApplicationController
  before_action :set_comments, only: %i[ show  ]

  def index
    @post = Post.find(params[ :id])
    @comments = @post.comments
  end

  def show
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[ :id])
  end

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_url(@comment, id: @comment.post_id), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    def set_comments
      @comments = Comment.all
    end
    def comment_params
      params.require(:comment).permit( :body, :post_id)
    end

