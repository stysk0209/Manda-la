class Element < ApplicationRecord

	belongs_to :mandala
	has_many :activities
	accepts_nested_attributes_for :activities, allow_destroy: true

end
