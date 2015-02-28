class Api::UsersController < Api::ApiController
  skip_before_filter :restrict_access

  def create
    @user = User.where(username: params[:user][:username]).first_or_initialize
    @user.token = params[:user][:token]
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
     def set_user
       @user = User.find(params[:id])
     end

     def user_params
      params.require(:user).permit(:username, :token)
     end

end
