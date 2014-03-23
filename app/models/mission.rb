class Mission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :user

  validates_presence_of :name
  validates_presence_of :user_id

  scope :persisted, -> { ne(name: nil) }

  def to_s;
    name
  end

end
