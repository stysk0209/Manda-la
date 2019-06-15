class Activity < ApplicationRecord

	belongs_to :element
	has_many :points, :dependent => :destroy
	accepts_nested_attributes_for :points, allow_destroy: true

end
