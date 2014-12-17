class Review < ActiveRecord::Base
	belongs_to :restaurant
	belongs_to :user
	validates :rating, inclusion: (1..5), :user_id {uniqueness: true}
end
