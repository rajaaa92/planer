require 'csv'

class Importer

  SEPARATOR = ',SEPARATOR,'

  def initialize options = {}
    @csv = options[:csv]
    @projects_ids_map = {}
  end

  def process
    import_data_from_csv
  end

  private

  def import_data_from_csv
    object_type = @csv.original_filename.include?('projects') ? :project : :item
    CSV.foreach(@csv.tempfile, headers: true, col_sep: SEPARATOR) { |row| row_to_object(object_type, row) }
    setup_parents if object_type == :project
  end

  def row_to_object object_type, row
    send("row_to_#{object_type}", row)
  end

  def row_to_item row
    Item.create!(name: row['name'], category: row['category'])
  end

  def row_to_project row
    project = Project.create!(name: row['name'])
    @projects_ids_map[row['_id']] = project.id
  end

  def setup_parents
    CSV.foreach(@csv.tempfile, headers: true, col_sep: SEPARATOR) { |row| setup_parent(row) }
  end

  def setup_parent row
    return unless row['parent_id'].present?
    old_id = row['_id']
    new_id = @projects_ids_map[old_id]
    project = Project.find(new_id)
    old_parent_id = row['parent_id']
    new_parent_id = @projects_ids_map[old_parent_id]
    parent = Project.find(new_parent_id)
    project.parent = parent
  end
end
