class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 2 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def self.downgrade_to_public(current_user)
    current_user.wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
  end
end
