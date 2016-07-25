class Keyword < ApplicationRecord
  has_many :urls
  validates :keyword, presence: true
end
