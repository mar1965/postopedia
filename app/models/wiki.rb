class Wiki < ApplicationRecord
  belongs_to :user

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 2 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  scope :visible_to, -> (user) { user ? all : where(private: false) }
end
