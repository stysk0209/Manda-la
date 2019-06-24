class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable

	has_many :mandalas, :dependent => :destroy
	has_many :tasks, :dependent => :destroy
	has_many :points, :dependent => :destroy
	accepts_nested_attributes_for :mandalas, allow_destroy: true

	validates :name,		presence: true,
							length: { maximum: 20 }
	validates :email,		presence: true,
							length: { maximum: 20 }
	validates :email,		presence: true,
							length: { maximum: 20 }

end
