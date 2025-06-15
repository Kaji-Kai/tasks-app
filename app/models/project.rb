class Project < ApplicationRecord
  #-----associations-----
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :tasks, dependent: :destroy
  has_many :comments, through: :tasks

  #-----validations-----
  validates :title, :owner_id, presence: true

end