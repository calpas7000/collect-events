class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_comment_user, only: [:destroy]
  
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
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to @event
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_comment_user
    @event = Event.find(params[:event_id])
    comment_author = current_user.comments.find_by(id: params[:id])
    event_author = current_user.events.find_by(id: params[:event_id])
    unless comment_author or event_author
      redirect_to @event
    else
      @comment = Comment.find(params[:id])
    end
  end
end
