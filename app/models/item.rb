class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Positionable

  field :name, type: String
  field :category, type: String

  belongs_to :user

  ALLOWED_CATEGORIES = %w(idea problem mission)
  DEFAULT_CATEGORY = 'idea'

  validates_presence_of :name
  validates_presence_of :user_id
  validate :category, presence: true, inclusion: ALLOWED_CATEGORIES

  scope :persisted, -> { ne(name: nil) }
  scope :for_user, ->(user) { where(user_id: user.id)}
  ALLOWED_CATEGORIES.each do |category|
    scope category.pluralize.to_sym, -> { where(category: category) }
  end

  def to_s;
    name
  end
end
