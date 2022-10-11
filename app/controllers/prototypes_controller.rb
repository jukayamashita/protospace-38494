class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: [:edit, :update]


  def index
    @prototypes = Prototype.all.includes(:user)
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
    @user = User.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update  
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to root_path
    else
      render :edit
    end
  end
 
  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      redirect_to root_path(@prototype)
    else
      render :new
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.delete
      redirect_to root_path(@prototype)
    else
      render :new
    end

  end

  def move_to_index
    unless user_signed_in? == current_user.name
      redirect_to root_path
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
