class PartiesController < ApplicationController

  def show
    @party = Party.find_by(name: params[:name])
  end

  def new
    @party = Party.new
  end

  def debug_index
    @parties = Party.all
  end

  def create
    @party = Party.new(party_params)
    if @party.save
      flash[:success] = "卓の作成に成功しました"
      redirect_to @party
    else
      flash[:failed] = "使用済みの卓名、もしくは記号が含まれています"
      render 'new', status: :unprocessable_entity
    end
  end

  def search
    @keyword = search_params[:keyword]
    @party = Party.find_by(name: @keyword)
    if !@keyword.nil?
      if !@party.nil?
        flash[:success] = "卓が見つかりました"
        redirect_to @party
      else
        flash[:failed] = "卓が見つかりませんでした・・・"
        render 'search', status: :unprocessable_entity
      end
    end
  end

  def destroy
    @party = Party.find_by(name: params[:name])
    @party.destroy
    flash[:success] = "卓を削除しました"
    redirect_to root_url, status: :see_other
  end

  def destroy_in_index
    @party = Party.find_by(name: params[:name])
    @party.destroy
    flash[:success] = "卓を削除しました"
    redirect_to debug_parties_path, status: :see_other
  end

  def update
    @party = Party.find_by(name: params[:name])
    @users = @party.users

    if params[:status]=="choosing"
      if @users.count{|u|u.sex=="boy"}>=1 && @users.count{|u|u.sex=="girl"}>=1
        @party.status = params[:status]
        @party.save
        flash[:success] = "メンバーの登録を締め切りました"
        redirect_to @party
      else
        flash[:failed] = "メンバーの締め切りに失敗しました。男女それぞれ最低1名の追加が必要です"
        redirect_to @party, status: :unprocessable_entity
      end

    elsif params[:status]=="resulting"
      if @users.count{|u|u.has_choosed} == @users.count
        @party.status = params[:status]
        @party.save
        redirect_to @party
      else
        flash[:failed] = "まだ全員の投票が終わっていません"
        redirect_to @party, status: :unprocessable_entity
      end
      
    end
    
  end


  private

    def party_params
      params.require(:party).permit(:name,:status,:allow_like)
    end

    def search_params
      params.permit(:keyword)
    end

end