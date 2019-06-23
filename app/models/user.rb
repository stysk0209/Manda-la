class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable

	has_many :mandalas, :dependent => :destroy
	has_many :tasks, :dependent => :destroy
	has_many :points, :dependent => :destroy
	accepts_nested_attributes_for :mandalas, allow_destroy: true

end
