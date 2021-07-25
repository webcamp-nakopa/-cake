class Admin::GenresController < ApplicationController

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
      flash[:notice] = "#{@genre.name}が追加されました"
    else
      render :index
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
       redirect_to admin_genres_path
       flash[:notice] = "#{@genre.name}が変更されました"
    else
       render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
    flash[:notice] = "#{@genre.name}が削除されました"
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
