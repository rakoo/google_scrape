class Url < ApplicationRecord
  belongs_to :keyword
  validates :keyword, presence: true
end
