json.extract! task, :id, :title, :description, :start_date, :due_date, :priority, :done, :created_at, :updated_at
json.url task_url(task, format: :json)
