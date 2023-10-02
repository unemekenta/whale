json.taggings do
  json.array! @taggings do |tagging|
    json.partial! partial: 'api/v1/common/tagging', tagging: tagging
  end
end
