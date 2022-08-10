class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
    @book_comment = BookComment.new

    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end

    #@see = See.find_by(ip: request.remote_ip)
    #if @see
      #@books = Book.find(params[:id])
    #else
      #@books = Book.find(params[:id])
      #See.create(ip: request.remote_ip)
    #end
  end

  def index
    if params[:latest]
      @books = Book.latest
    elsif params[:star_count]
      @books = Book.star_count
    else
      to = Time.current.at_end_of_day
      from = (to - 6.day).at_beginning_of_day
      @books = Book.includes(:favorited_users).
        sort {|a,b|
          b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
          a.favorited_users.includes(:favorites).where(created_at: from...to).size
        }
    end
    @book = Book.new
    @user = current_user

    #@book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end

    #@see = See.find_by(ip: request.remote_ip)
    #if @see
     # @books = Book.all
    #else
     # @books = Book.all
      #See.create(ip: request.remote_ip)
    #end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image, :category, :star)
  end



  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
