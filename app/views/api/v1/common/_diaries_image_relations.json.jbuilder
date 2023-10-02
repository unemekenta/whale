json.diaries_image_relations do
  json.array! diaries_image_relations do |diaries_image_relation|
    json.partial! partial: 'api/v1/common/diaries_image_relation', diaries_image_relation: diaries_image_relation
  end
end