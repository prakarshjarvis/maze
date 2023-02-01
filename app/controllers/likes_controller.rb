class LikesController < ApplicationController
    def create
        @like = current_user.likes.new(like_params)
        if !@like.save
            flash[:notice] = @like.errors.full_messages.to_sentence
        end
        redirect_to posts_path
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        like = @like.likeable
        @like.destroy
        redirect_to posts_path
    end

    private

    def like_params
        params.require(:like).permit(:likeable_id, :likeable_type)
    end

end
