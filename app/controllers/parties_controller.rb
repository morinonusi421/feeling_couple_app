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

  private

    def party_params
      params.require(:party).permit(:name)
    end

    def search_params
      params.permit(:keyword)
    end

end