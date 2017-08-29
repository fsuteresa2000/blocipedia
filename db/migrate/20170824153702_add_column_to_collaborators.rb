class AddColumnToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :wiki_id, :integer
  end
end
