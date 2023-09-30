json.diaries do
  json.array! @diaries do |diary|
    json.partial! partial: 'api/v1/common/diary', diary: diary
    json.partial! partial: 'api/v1/common/images', images: diary.images
    json.partial! partial: 'api/v1/common/diary_comments', diary_comments: diary.diary_comments
  end
end

json.partial! partial: 'api/v1/common/pagination', data: @diaries
