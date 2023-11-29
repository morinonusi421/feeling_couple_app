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
      flash[:userform] = "メンバーの追加に成功しました"
      redirect_to @party
    else
      @users = @party.users
      flash[:userform] = "メンバーの追加に失敗しました"
      #render template: "parties/show", status: :unprocessable_entity
      redirect_to @party , status: :unprocessable_entity
    end
  end

  

  private

    def user_params
      params.require(:user).permit(:name,:sex)
    end


end
