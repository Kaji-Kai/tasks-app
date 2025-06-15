class Task < ApplicationRecord
  #-----associations-----
  belongs_to :owner, class_name: 'User'
  belongs_to :project
  has_many :comments

  #-----enums-----
  enum priority: {
    low: "low",
    medium: "medium",
    high: "high"
  }

  #-----validations-----
  validates :project_id, :title, :priority, presence: true

end