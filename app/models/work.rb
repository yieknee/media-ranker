class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes
  has_many :users, through: :votes

  def self.spotlight
    works = Work.all
    max = 0
    works.each do |work|
      max = work.votes.count if work.votes.count > max
    end
    return works.select{|work| work.votes.count == max }.sample
  end

  def self.top_ten(category: category)
    works = Work.where(category: category)
    return works.sort_by{|work| -work.votes.count}.take(10)
  end

end
