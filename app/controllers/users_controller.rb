class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @private_wikis = WikiPolicy::Scope.new(@user, Wiki).my_private_wiki
    @public_wikis = WikiPolicy::Scope.new(@user, Wiki).my_public_wiki
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "Your Premium status has been changed to Guest status. All of your Wikis are now public."
      redirect_to root_path
    else
      flash[:error] = "An error has occurred when attempting to convert your account."
      redirect_to root_path
    end
  end

   private

   def user_params
     params.require(:user).permit(:name, :email, :role)
   end

end
