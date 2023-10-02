json.images do
  json.array! images do |image|
    json.partial! partial: 'api/v1/common/image', image: image
  end
end
