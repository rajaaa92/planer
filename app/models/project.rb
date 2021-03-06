require 'csv'

class Project < ActiveRecord::Base
  include Positionable

  belongs_to :user
  belongs_to :parent, class_name: "Project"
  has_many :subprojects, class_name: "Project", foreign_key: :parent_id, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :user_id

  scope :persisted, -> { where.not(name: nil) }
  scope :roots, -> { where(parent_id: nil) }

  def to_s;
    name
  end

  def root?
    parent == nil
  end

  def self.as_csv
    CSV.generate(col_sep: Importer::SEPARATOR) do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  private

  def self.column_names
    %w(_id name parent_id position)
  end
end
