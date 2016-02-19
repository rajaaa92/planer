module Positionable
  extend ActiveSupport::Concern

  included do
    default_scope -> { order(position: :asc) }

    before_create :set_position

    def self.next_position
      (self.last.try(:position) || 0) + 1
    end

    def update_position new_position
      update_attribute(:position, new_position)
    end

    private

    def set_position
      self.position = self.class.next_position
    end
  end
end
