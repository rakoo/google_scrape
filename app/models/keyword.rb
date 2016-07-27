class Keyword < ApplicationRecord
  belongs_to :report
  has_many :urls
  validates :keyword, presence: true
end
