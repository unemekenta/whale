json.diary do
  json.partial! partial: 'api/v1/common/diary', diary: @diary
  json.partial! partial: 'api/v1/common/images', images: @diary.images
  json.partial! partial: 'api/v1/common/diary_comments', diary_comments: @diary.diary_comments
  json.partial! partial: 'api/v1/common/diaries_image_relations', diaries_image_relations: @diary.diaries_image_relations
  json.user do
    json.partial! partial: 'api/v1/common/user', user: @diary.user
  end
end
