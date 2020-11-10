class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build(content: comment_params[:content], user_id: current_user.id)
    if @comment.save
      flash[:success] = "コメントを投稿しました。"
      redirect_to @event
    else
      @comments = @event.comments.order(id: :desc)
      counts_event(@event)
      flash.now[:danger] = "コメントの投稿に失敗しました。"
      render "events/show"
    end
  end

  def destroy
    @commnet.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_back(fallback_location: root_path)
  end
end

private

def comment_params
  params.require(:comment).permit(:content)
end
