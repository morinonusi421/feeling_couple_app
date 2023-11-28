class Party < ApplicationRecord
  has_many :users,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
end
