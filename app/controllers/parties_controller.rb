class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
    @user = @party.users.build
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

  private

    def party_params
      params.require(:party).permit(:name)
    end

end