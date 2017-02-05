json.extract! user, :id, :name, :email, :cart_id, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)