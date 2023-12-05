class Party < ApplicationRecord
  enum status: { recruiting: 0, choosing: 10 , resulting: 20}
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
      if !boy.loving.nil?
        if boy.loving.loving == boy
          lovers.append([boy,boy.loving])
        end
      end
    end
    lovers
  end

end
