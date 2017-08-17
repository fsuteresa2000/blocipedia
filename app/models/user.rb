class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.role ||= :guest }
  before_save { self.email = email.downcase if self.email.present? }

  enum role: [:guest, :member, :admin]

  has_many :wikis, dependent: :destroy
end
