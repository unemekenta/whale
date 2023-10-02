json.id task.id
json.title task.title
json.description task.description
json.priority task.priority
json.status task.status
json.deadline task.deadline
json.updated_at task.updated_at

json.tags do
  json.array! task.tags do |tag|
    json.partial! partial: 'api/v1/common/tag', tag: tag
  end
end

json.taggings do
  json.array! task.taggings do |tagging|
    json.partial! partial: 'api/v1/common/tagging', tagging: tagging
  end
end

json.user do
  json.partial! partial: 'api/v1/common/user', user: task.user
end

json.comment do
  json.array! task.comments do |comment|
    json.partial! partial: 'api/v1/common/comment', comment: comment
  end
end