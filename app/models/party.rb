class Party < ApplicationRecord
  enum status: { registering: 0, choosing: 10 , resulting: 20}
  has_many :users,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true

  def boys
    self.users.select{|u|u.sex=="boy"}
  end

  def girls
    self.users.select{|u|u.sex=="girl"}
  end

  def lovers
    lovers = []
    self.boys.each do |boy|
      if boy.loved.include?(boy.loving)
        lovers.append([boy,boy.loving])
      end
    end
    lovers
  end

  def not_lovers
    all_lovers = self.lovers.flatten
    not_lovers = self.users.select{|u| !all_lovers.include?(u)}
    not_lovers
  end
end
