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
    #-1は誰も好きじゃないことを表すダミーデータ
    if user_params[:loving_id] != "-1"
      @user.update(user_params)
    end
    @user.has_choosed = true
    @user.save
    flash[:success] = @user.name + "さんの投票が完了しました"
    redirect_to @user.party
  end

  def destroy
    @user = User.find(params[:id])
    @party = @user.party
    @user.destroy
    flash[:success] = "メンバーを削除しました"
    redirect_to @party, status: :see_other
  end
  

  private

    def user_params
      params.require(:user).permit(:name,:sex,:loving_id)
    end


end
