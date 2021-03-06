class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /user/:id/categories
  def index
    @user = User.find(params[:user_id])
    @categories = @user.categories.all
    render json: @categories
  end


  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def new
    @user = User.find(params[:user_id])
    @category = Category.new
  end


  def create
    @user = User.find(params[:user_id])
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    @category = Category.find(params[:id])
    if @category.update!(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @user = User.find(params[:user_id])
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:title, :user_id, :id)
    end
end
