class RenameNoteToMeasurementType < ActiveRecord::Migration[5.2]
  def change
    rename_column :measures, :note, :measurement_type
  end
end
