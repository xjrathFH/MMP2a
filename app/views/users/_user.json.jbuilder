json.extract! user, :id, :email, :name, :class_of, :balance, :created_at, :updated_at
json.url user_url(user, format: :json)
