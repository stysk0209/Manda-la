class Activity < ApplicationRecord

	belongs_to :element
	has_many :points
	accepts_nested_attributes_for :points, allow_destroy: true

end
