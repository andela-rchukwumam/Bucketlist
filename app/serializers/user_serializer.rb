class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name
  has_many :lists, dependent: :destroy
  has_many :items, through: :lists, dependent: :destroy
end
