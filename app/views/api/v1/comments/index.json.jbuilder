json.comment do
  json.array! @comments do |comment|
    json.partial! partial: 'api/v1/common/comment', comment: comment
  end
end

json.partial! partial: 'api/v1/common/pagination', data: @comments
