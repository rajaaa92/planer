class Idea
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :position, type: Integer

  belongs_to :user

  validates_presence_of :name
  validates_presence_of :user_id

  default_scope -> { order(position: :asc) }
  scope :persisted, -> { ne(name: nil) }

  def to_s;
    name
  end

end
