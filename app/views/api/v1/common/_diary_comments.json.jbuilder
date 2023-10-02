json.diary_comments do
  json.array! diary_comments do |diary_comment|
    json.partial! partial: 'api/v1/common/diary_comment', diary_comment: diary_comment
  end
end