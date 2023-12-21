class Party < ApplicationRecord
  enum status: { registering: 0, choosing: 10 , resulting: 20}
  has_many :users,dependent: :destroy
  validates :name,  presence: true, uniqueness: true
  validate :validate_name_format
  validates :allow_like, inclusion: { in: [true, false] }


  def to_param
    name
  end

  def validate_name_format
    if name.present?
      unless name.match?(/\A[\p{Hiragana}\p{Katakana}\p{Han}\dA-Za-z]+\z/)
        errors.add(:name, "はひらがな、カタカナ、漢字、数字、半角英語、全角英語のみ許可されます")
      end
    end
  end

  def boys
    self.users.select{|u|u.sex=="boy"}
  end

  def girls
    self.users.select{|u|u.sex=="girl"}
  end

  def couples_allow_like(decided_couples)

    rest_boys = self.boys.select{|u| !decided_couples.flatten.include?(u)}
    rest_girls = self.girls.select{|u| !decided_couples.flatten.include?(u)}

    #まだカップルが決まっていない男女それぞれの人数
    xn = rest_boys.count
    yn = rest_girls.count
    
    # edges[x]: xとつながるYの頂点のset
    edges = Array.new(xn) { Set.new }
    # matched[y]: yとマッチングされたXの頂点(暫定)
    matched = Array.new(yn, -1)
    
    #edgesに辺を追加していく
    (0..xn-1).each do |i|
      boy = rest_boys[i]
      (0..yn-1).each do |j|
        girl = rest_girls[j]
        if boy.liking.include?(girl) && girl.liking.include?(boy)
          edges[i].add(j)
        end
      end
    end

    #増大路を発見し、matchedを書き換えるdfs
    def dfs(v,edges,matched,visited)
      edges[v].each do |u|
        next if visited.include?(u)
        visited.add(u)
        if matched[u] == -1 || dfs(matched[u], edges, matched, visited)
          matched[u] = v
          return true
        end
      end
      return false
    end

    #余り男全員を始点にdfsをする
    (0..xn-1).each do |start|
        dfs(start,edges,matched,Set.new)
    end
    
    #matchedをもとにcoupleを追加して終わり
    (0..yn-1).each do |i|
      if matched[i]!=-1
        boy = rest_boys[matched[i]]
        girl = rest_girls[i]
        decided_couples.append([boy,girl])
      end
    end

    return decided_couples
  end


  def couples
    couples = []
    self.boys.each do |boy|
      if boy.loved.include?(boy.loving)
        couples.append([boy,boy.loving])
      end
    end
    #likeを許可するpartyなら、さらに本命以外もマッチングさせる
    if self.allow_like
      return couples_allow_like(couples)
    else
      return couples
    end
  end

  def not_couples
    not_couples = self.users.select{|u| !self.couples.flatten.include?(u)}
    not_couples
  end
end
