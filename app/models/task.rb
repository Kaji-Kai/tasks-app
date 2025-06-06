class Task < ApplicationRecord
  enum priority: {
    low: "low",
    medium: "medium",
    high: "high"
  }

  validates :title, presence: true
  validates :priority, presence: true

end
