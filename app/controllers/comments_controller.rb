class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to controller: "studies", action: "show", id: @comment.study_id
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:study_id, :content)
  end
end
