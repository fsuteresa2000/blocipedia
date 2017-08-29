class AddEmailToCollaborators < ActiveRecord::Migration
  def change
    add_colum :collaborators, :email, :string
  end
end
