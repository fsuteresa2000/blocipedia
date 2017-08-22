class Wiki < ActiveRecord::Base
  belongs_to :user

  def private?
   self.private == true
  end

  private

  def make_public
    self.private = false
  end

end
