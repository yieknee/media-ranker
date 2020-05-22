class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work_id, uniqueness:{scope: :user_id}, presence: :true
  validates :user_id, uniqueness:{scope: :work_id}, presence: :true
end
