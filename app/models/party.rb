class Party < ApplicationRecord
  enum status: { recruiting: 0, choosing: 10 , resulting: 20}
  has_many :users,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
end
