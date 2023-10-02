json.information_contents do
  json.array! @information_contents do |information_content|
    json.partial! partial: 'api/v1/common/information_content', information_content: information_content
  end
end

json.partial! partial: 'api/v1/common/pagination', data: @information_contents
