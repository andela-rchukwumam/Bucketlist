class Item < ActiveRecord::Base
  belongs_to :list
  validates :name, presence: true, length: { minimum: 3 }
  validates :list_id, presence: true
end
