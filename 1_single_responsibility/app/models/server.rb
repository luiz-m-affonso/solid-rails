class Server < ApplicationRecord
  has_many :apps
  validates :name, presence: true
end