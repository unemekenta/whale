json.tasks do
  json.array! @tasks do |task|
    json.partial! partial: 'api/v1/common/task', task: task
  end
end

json.partial! partial: 'api/v1/common/pagination', data: @tasks