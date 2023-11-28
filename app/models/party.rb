class Party < ApplicationRecord
  enum status: { 登録中: 0, 選択中: 10 , 結果表示: 20}
  has_many :users,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
end
