class Comment < ApplicationRecord
  #-----associations-----
  belongs_to :task
  belongs_to :owner, class_name: 'User'
  def project
    task.project
  end

  #-----validations-----
  validates :task_id, :owner_id, presence: true

end