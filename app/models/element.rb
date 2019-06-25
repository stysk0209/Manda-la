class Element < ApplicationRecord

	belongs_to :mandala
	has_many :activities, :dependent => :destroy
	has_many :tasks, :dependent => :destroy
	accepts_nested_attributes_for :activities, allow_destroy: true

end
