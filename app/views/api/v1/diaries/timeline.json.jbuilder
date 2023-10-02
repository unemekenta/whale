json.diaries do
  json.array! @diaries do |diary|
    json.partial! partial: 'api/v1/common/diary', diary: diary
    json.partial! partial: 'api/v1/common/images', images: diary.images
    json.user do
      json.partial! partial: 'api/v1/common/user', user: diary.user
    end
  end
end

json.partial! partial: 'api/v1/common/pagination', data: @diaries
