class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    @party = Party.first
    @user = @party.users.build(user_params)
    @user.save
  end

  

  private

    def user_params
      params.require(:user).permit(:name)
    end


end
