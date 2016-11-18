json.extract! author, :id, :name, :password, :created_at, :updated_at
json.url author_url(author, format: :json)