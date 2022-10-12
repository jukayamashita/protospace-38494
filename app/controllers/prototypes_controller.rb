class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_prototype, only: [:edit, :show, :edit, :update, :destroy]



  def index
    @prototypes = Prototype.all.includes(:user)
  end

  def show
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
    @user = User.new
  end

  def edit
  end

  def update  
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path(@prototype)
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
    if @prototype.destroy
      redirect_to root_path(@prototype)
    else
      render :new
    end

  end

  def move_to_index
    redirect_to root_path unless current_user.id == @prototype.user.id
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

end