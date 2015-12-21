class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_created, :date_updated, :created_by
  has_many :items

  def date_created
    object.created_at
  end

  def date_updated
    object.updated_at
  end

  def created_by
    current_user.full_name
  end
end
