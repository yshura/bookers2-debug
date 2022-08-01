class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
       #render :comment_index
    #else
       #redirect_back(fallback_location: root_path)
    #end
    @books = Book.find(params[:book_id])
  end

  def destroy
    @comment = BookComment.find(params[:id])
    #redirect_to book_path(params[:book_id])
    @comment.destroy
    @books = Book.find(params[:book_id])
    @book = Book.find(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end

