require 'rails_helper'

feature 'reviewing' do

	before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
		Restaurant.create name: 'KFC' 
	end

	scenario 'allows authenticated users to leave a review using a form' do
		visit '/restaurants'
		click_link 'Review KFC'
		fill_in 'Thoughts', with: 'mingtastic'
		select '3', from: 'Rating'
		click_button 'Leave Abuse'
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content('mingtastic')
	end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Abuse'
  end

  def second_user_signs_in
    click_link('Sign up')
    fill_in('Email', with: 'test1@example.com')
    fill_in('Password', with: 'test1test')
    fill_in('Password confirmation', with: 'test1test')
    click_button('Sign up')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('PLAIN JANE', '3')
    click_link 'Sign out'
    second_user_signs_in
    leave_review('FOUND MYSELF AT THIS GAFF', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

  # scenario 'displays how long ago a given review was added' do 
  #   leave_review('PLAIN JANE', '3')
  #   Restaurant.last.reviews.last.update_attributes(:created_at => Time.now - 3600)
  #   expect(page).to have_content('1 hour ago')
  # end

end