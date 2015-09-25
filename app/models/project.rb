class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :position, type: Integer

  belongs_to :user
  belongs_to :parent, class_name: "Project"
  has_many :subprojects, class_name: "Project", dependent: :destroy

  validates_presence_of :name
  validates_presence_of :user_id

  default_scope -> { order(position: :asc) }

  scope :persisted, -> { ne(name: nil) }
  scope :roots, -> { where(parent_id: nil) }

  before_create :set_position

  def to_s;
    name
  end

  def root?
    parent == nil
  end

  def self.next_position
    Project.last.position + 1
  end

  private

  def set_position
    self.position = Project.last.position + 1
  end

end
