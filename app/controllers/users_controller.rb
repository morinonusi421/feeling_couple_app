class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    #遷移元url末尾を取得　paries/2 だったらparty_id = 2
    @party_id = request.referer.split("/")[-1].to_i
    @party = Party.find(@party_id)
    @user = @party.users.build(user_params)
    if @user.save
      flash[:success] = "メンバーの追加に成功しました"
      redirect_to @party
    else
      render template: "parties/show", status: :unprocessable_entity
    end
  end

  

  private

    def user_params
      params.require(:user).permit(:name)
    end


end
