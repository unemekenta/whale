json.tags do
  json.array! @tags do |tag|
    json.partial! partial: 'api/v1/common/tag', tag: tag
  end
end

json.partial! partial: 'api/v1/common/pagination', data: @tags