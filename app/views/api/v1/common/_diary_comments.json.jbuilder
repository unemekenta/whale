json.diary_comments do
  json.array! diary_comments do |diary_comment|
    json.id diary_comment.id
    json.user_id diary_comment.user_id
    json.diary_id diary_comment.diary_id
    json.content diary_comment.content
    json.updated_at diary_comment.updated_at
    json.user do
      json.partial! partial: 'api/v1/common/user', user: diary_comment.user
    end
  end
end