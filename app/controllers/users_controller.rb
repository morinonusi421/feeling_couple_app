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
      @users = @party.users
      flash[:failed] = "メンバーの追加に失敗しました"
      redirect_to @party , status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    @user.has_choosed = true
    if @user.update(user_params)
      flash[:success] = @user.name + "さんの投票が完了しました"
      redirect_to @user.party
    else
      flash[:debug] = "不明なエラー．作成者にお知らせください"
      redirect_to @user 
    end
  end
  

  private

    def user_params
      params.require(:user).permit(:name,:sex,:loving_id)
    end


end
