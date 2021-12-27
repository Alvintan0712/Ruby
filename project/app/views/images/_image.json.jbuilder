json.extract! image, :id, :product_id, :image, :created_at, :updated_at
json.url image_url(image, format: :json)
json.image url_for(image.image)
