class Mandala < ApplicationRecord

	belongs_to :user
	has_many :elements, :dependent => :destroy
	accepts_nested_attributes_for :elements, allow_destroy: true

	validates :target,    length: { in: 1..30 }

end
