class User < ApplicationRecord
  enum sex: { 男の子: 0, 女の子: 1 }
  belongs_to :party
  validates :name,  presence: true, length: { maximum: 10 }, uniqueness: { scope: :party_id }
  validates :sex, presence: true

  #def self.search(keyword)
  #  if keyword.present?
  #   where('name LIKE ?', "#{keyword}%")
  #  else
  #    all
  #  end
  #end
end
