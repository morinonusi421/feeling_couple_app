class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def create
    #遷移元url末尾を取得　/parties/gokon だったらparty_name = gokon
    #URLパラメータは日本語だと%EC...とエンコードされてるので、デコードする
    @party_name = URI.decode_www_form_component(request.referer.split("/")[-1])
    @party = Party.find_by(name: @party_name)
    @user = @party.users.build(user_params)
    if @user.save
      flash[:success] = "メンバーの登録に成功しました"
      redirect_to @party
    else
      @users = @party.users
      flash[:failed] = "メンバーの登録に失敗しました"
      redirect_to @party , status: :unprocessable_entity
    end
  end


  def update
    @user = User.find(params[:id])
    if user_params[:loving_id]!= "-1"
      loving_id = user_params[:loving_id]
      @user.loving = User.find(loving_id)
      @user.liking << User.find(loving_id)
    end
    user_params[:liking_ids]&.each do |liking_id|
      if loving_id != liking_id #二重追加は避ける
        @user.liking << User.find(liking_id)
      end
    end
    @user.has_choosed = true
    @user.save
    flash[:success] = @user.name + "さんの選択が完了しました"
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
      params.require(:user).permit(:name,:sex,:loving_id,liking_ids: [])
    end


end
