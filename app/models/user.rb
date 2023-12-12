class User < ApplicationRecord
  enum sex: { boy: 0, girl: 1 }
  belongs_to :party
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: { scope: :party_id }
  validates :sex, presence: true

  has_many :loved, class_name: "User", foreign_key: "loving_id", dependent: :nullify
  belongs_to :loving, class_name: "User", optional: true, inverse_of: :loved

  has_many :active_likes, class_name:  "Like",
                          foreign_key: "liker_id",
                          dependent:   :destroy
  has_many :passive_likes, class_name:  "Like",
                          foreign_key: "liked_id",
                          dependent:   :destroy
  has_many :liking, through: :active_likes, source: :liked
  has_many :likers, through: :passive_likes, source: :liker

end