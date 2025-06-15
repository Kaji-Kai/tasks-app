class Role < ApplicationRecord
  #-----associations-----
  has_many :users

  #-----validations-----
  validates :role_type, presence: true

end