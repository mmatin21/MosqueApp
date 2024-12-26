module Types
  class MasjidType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :created_at,  GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at,  GraphQL::Types::ISO8601DateTime, null: true
  end
end