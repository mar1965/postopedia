class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis, dependent: :destroy

  after_initialize :init
  before_save { self.email = email.downcase }

  enum role: [:standard, :admin, :premium]

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }


  def init
    self.role ||= :standard
  end

end
