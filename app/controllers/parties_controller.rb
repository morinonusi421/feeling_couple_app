class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
    @users = @party.users
    @newuser = @party.users.build
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)
    if @party.save
      flash[:success] = "パーティの作成に成功しました"
      flash[:success] = party_params.inspect
      redirect_to @party
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def search
    @keyword = search_params[:keyword]
    @party = Party.find_by(name: @keyword)
    if !@keyword.nil?
      if !@party.nil?
        flash[:success] = "パーティが見つかりました"
        redirect_to @party
      else
        flash[:failed] = "パーティが見つかりませんでした・・・"
        render 'search', status: :unprocessable_entity
      end
    end
  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy
    flash[:success] = "パーティを削除しました"
    redirect_to root_url, status: :see_other
  end

  def update
    @party = Party.find(params[:id])
    @party.status = params[:status]
    @party.save
    if params[:status]=="choosing"
      flash[:success] = "メンバーの追加を締め切りました"
    end
    redirect_to @party
  end


  private

    def party_params
      params.require(:party).permit(:name)
    end

    def search_params
      params.permit(:keyword)
    end

end