class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.all.page(params[:page]).per Settings.number_page
  end
    
  def show
    @users = User.all.page(params[:page]).per Settings.number_page
    @microposts = @user.microposts.des_post.page(params[:page]).per Settings.number_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".active"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".undelete"
    end
      redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end

    def correct_user
      @user = User.find_by id: params[:id]
      return if current_user? @user
      flash[:danger] = t ".incorrect"
      redirect_to root_url
    end

    def admin_user
      return if current_user.admin?
      flash[:danger] = t ".user"
      redirect_to root_url
    end 

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t ".failuser"
      redirect_to root_url
    end
end
