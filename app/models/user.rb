class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase if self.email.present? }
  before_save { self.role ||= :member}

  enum role: [:guest, :member, :admin]

  has_many :wikis, dependent: :destroy

  before_create :make_guest

  def going_public
    self.wikis.each { |wiki| puts wiki.publicize }
  end

  def guest?
    role == 'guest'
  end

  def member?
    role == 'member'
  end

  def admin?
    role == 'admin'
  end

  def downgrade_account
    self.update_attribute(:role, 'guest')
  end


  private

  def make_guest
    self.role = 'guest'
  end
end
