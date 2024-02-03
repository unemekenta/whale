json.id comment.id
json.content comment.content
json.updated_at comment.updated_at
json.user do
  json.partial! partial: 'api/v1/common/user', user: comment.user
end
json.is_own_comment comment.is_own_comment?(current_api_v1_user)
