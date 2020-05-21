class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  def self.spotlight
    works = Work.all
    return works.sample
  end

end
