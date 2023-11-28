class Party < ApplicationRecord
  has_many :users,dependent: :destroy
end
