class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :position, type: Integer
  field :category, type: String

  belongs_to :user

  ALLOWED_CATEGORIES = %w(idea problem mission)
  DEFAULT_CATEGORY = 'idea'

  validates_presence_of :name
  validates_presence_of :user_id
  validate :category, presence: true, inclusion: ALLOWED_CATEGORIES

  default_scope -> { order(position: :asc) }
  scope :persisted, -> { ne(name: nil) }
  scope :for_user, ->(user) { where(user_id: user.id)}
  ALLOWED_CATEGORIES.each do |category|
    scope category.pluralize.to_sym, -> { where(category: category) }
  end

  before_create :set_position

  def to_s;
    name
  end

  def self.next_position_for category
    Item.send(category.pluralize).last.position + 1
  end

  private

  def set_position
    self.position = (Item.last.try(:position) || 0) + 1
  end
end
