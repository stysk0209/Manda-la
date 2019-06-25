class Task < ApplicationRecord

	belongs_to :user
	belongs_to :element

	validates :content,		presence: true,
							length: { maximum: 20 }
	validates :limit,	presence: true,
						length: { maximum: 10 }

end
