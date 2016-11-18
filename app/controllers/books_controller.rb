class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    if !session[:author]
      redirect_to authors_path, :alert => "Necesitas iniciar sesion para regisrar un libro"
    else
      @book = Book.new
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    if @book.author.name != session[:author]
      redirect_to books_path, :alert => "No puedes editar un libro de otro autor"
    else
      @book = Book.find(params[:id])
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.author = Author.find_by name: session[:author]

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.author.name != session[:author]
      redirect_to books_path, :alert => "No puedes eliminar el libro de otro autor"
    else
      @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author_id)
    end
end
