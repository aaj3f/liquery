class AddNoteToMeasures < ActiveRecord::Migration[5.2]
  def change
    add_column :measures, :note, :string
  end
end
