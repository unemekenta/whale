json.images do
  json.array! images do |image|
    json.id image.id
    json.image image.image
    json.caption image.caption
  end
end
