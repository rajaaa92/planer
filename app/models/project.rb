class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :user
  belongs_to :parent, class_name: "Project"
  has_many :subprojects, class_name: "Project", dependent: :destroy

  validates_presence_of :name

  scope :persisted, -> { ne(name: nil) }

  def to_s;
    name
  end

end
