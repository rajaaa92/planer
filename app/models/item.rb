require 'csv'

class Item < ActiveRecord::Base
  include Positionable

  belongs_to :user

  ALLOWED_CATEGORIES = %w(idea problem mission)
  DEFAULT_CATEGORY = 'idea'

  validates_presence_of :name
  validates_presence_of :user_id
  validates :category, presence: true, inclusion: ALLOWED_CATEGORIES

  scope :persisted, -> { where.not(name: nil) }
  scope :for_user, ->(user) { where(user_id: user.id)}
  ALLOWED_CATEGORIES.each do |category|
    scope category.pluralize.to_sym, -> { where(category: category) }
  end

  def to_s;
    name
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
    %w(_id name category position)
  end
end
