class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  def self.spotlight
    works = Work.all
    return works.sample
  end

  def self.top_ten(category: category)
    works = Work.where(category: category)
    top_ten = []
    if works.count < 10
      top_ten = works
    else
      10.times do
        top_ten << works.sample
      end
    end
    return top_ten
  end

end
