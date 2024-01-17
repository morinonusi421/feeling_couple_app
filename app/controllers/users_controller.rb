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
      flash[:success] = "メンバーの登録に成功しました。"
      redirect_to @party
    else
      @users = @party.users
      flash[:failed] = "メンバーの登録に失敗しました。(同じ名前は登録できません)"
      redirect_to @party , status: :unprocessable_entity
    end
  end


  def bundle_create
    @party_name = URI.decode_www_form_component(request.referer.split("/")[-1])
    @party = Party.find_by(name: @party_name)
    users_data = params[:user][:users_data].split("\n")
    boy_alias = ["男","男の子","おとこ","おとこのこ"]
    girl_alias = ["女","女の子","おんな","おんなのこ"]

    users_data.each do |user_data|
      #ちゃんと空白区切りになっているかチェック
      if user_data.count(" ") == 1
        name, sex = user_data.split(" ")
      elsif user_data.count("　") == 1
        name, sex = user_data.split("　")
      else
        flash[:failed] = "名前と性別を、空白区切りで入力してください"
        redirect_to @party, status: :unprocessable_entity
        return
      end

      #性別が正しく入力されているかチェック
      sex = "boy" if boy_alias.include?(sex)
      sex = "girl" if girl_alias.include?(sex)
      if ["boy","girl"].exclude?(sex)
        flash[:failed] = "名前と性別を、空白区切りで入力してください"
        redirect_to @party, status: :unprocessable_entity
        return
      end
    
      @party.users.build(name: name, sex: sex)

    end

    if @party.save and !users_data.empty?
      flash[:success] = "メンバーの登録に成功しました"
      redirect_to @party
    else
      flash[:failed] = "メンバーの登録に失敗しました。(同じ名前は登録できません)"
      redirect_to @party, status: :unprocessable_entity
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
