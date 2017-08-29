class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :wikis, dependent: :destroy

   after_initialize :initialize_role

   enum role: [:guest, :member, :admin]

   private

   def initialize_role
     self.role ||= :guest
   end
 end
