class User < ApplicationRecord
  enum sex: { boy: 0, girl: 1 }
  belongs_to :party
  validates :name,  presence: true, length: { maximum: 10 }, uniqueness: { scope: :party_id }
  validates :sex, presence: true

  has_many :loved, class_name: "User", foreign_key: "loving_id", dependent: :nullify

  belongs_to :loving, class_name: "User", optional: true, inverse_of: :loved
  

end