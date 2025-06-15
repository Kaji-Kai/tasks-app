class User < ApplicationRecord
  before_validation :set_default_role, on: :create

  #-----devise-----
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #-----associations-----
  belongs_to :role, optional: false
  has_many :projects, class_name: "Project", foreign_key: :owner_id, dependent: :destroy
  has_many :owned_tasks, class_name: "Task", foreign_key: :owner_id, dependent: :destroy
  has_many :comments, class_name: "Comment", foreign_key: :owner_id, dependent: :destroy

  #-----validations-----
  validates :role_id, presence: true


  private
  def set_default_role
    self.role ||= Role.find_by!(role_type: "User")
  end
end