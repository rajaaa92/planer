class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :user
  belongs_to :parent, class_name: "Project"
  has_many :subprojects, class_name: "Project", dependent: :destroy

  def to_s;
    name
  end

end
