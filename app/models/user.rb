class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase if self.email.present? }
  before_save { self.role ||= :member}

  enum role: [:guest, :member, :admin]

  has_many :wikis, dependent: :destroy

  before_create :make_standard

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def downgrade_account
    self.update_attribute(:role, 'standard')
  end


  private

  def make_standard
    self.role = 'standard'
  end
end
