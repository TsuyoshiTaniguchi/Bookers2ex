class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
  
    if @book_comment.save
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.json { render json: @book_comment, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @book_comment.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
