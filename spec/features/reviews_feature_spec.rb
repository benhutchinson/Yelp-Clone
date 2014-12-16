require 'rails_helper'

feature 'reviewing' do

	before {Restaurant.create name: 'KFC'}

	scenario 'allows users to leave a review using a form' do
		visit '/restaurants'
		click_link 'Review KFC'
		fill_in 'Thoughts', with: 'mingtastic'
		select '3', from: 'Rating'
		click_button 'Leave Abuse'
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content('mingtastic')
	end

end