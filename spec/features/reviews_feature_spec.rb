require 'rails_helper'
require 'timecop'

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

  scenario 'displays if it was created less than an hour ago' do 
    leave_review('PLAIN JANE', '3')
    expect(page).to have_content('Reviewed less than an hour ago')
  end

  scenario 'displays how many hours ago it was created if more than an hour ago' do 
    leave_review('PLAIN JANE', '3')
    # here, the review entry in the database is manually altered in the database
    # this is one way of simulating time for the purposes of the test
    # a page refresh is simulated since the user is already on
    # the applicable page following submission of the review
    Restaurant.last.reviews.last.update_attributes(:created_at => Time.now - 7200)
    Restaurant.last.reviews.last
    visit '/'
    expect(page).to have_content('Reviewed around 2 hours ago')
  end

  scenario 'displays yesterday it was created yesterday' do 
    # this is another alternative, deploying a gem called Timecop
    leave_review('PLAIN JANE', '3')
    Timecop.travel(Time.now + 100000)
    visit '/'
    expect(page).to have_content('Reviewed yesterday')
  end

  scenario 'displays the number of days ago it was created if it was more than a day ago' do 
    leave_review('PLAIN JANE', '3')
    Restaurant.last.reviews.last.update_attributes(:created_at => Time.now - 172800)
    Restaurant.last.reviews.last
    visit '/'
    expect(page).to have_content('Reviewed 2 days ago')
  end

end