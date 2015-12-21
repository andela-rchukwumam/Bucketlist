class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :date_created, :date_updated

  def date_created
    object.created_at
  end

  def date_updated
    object.updated_at
  end
end
