require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 1, thoughts: 'It was an abomination')
  end

  def second_user_signs_in
    click_link('Sign up')
    fill_in('Email', with: 'test1@example.com')
    fill_in('Password', with: 'test1test')
    fill_in('Password confirmation', with: 'test1test')
    click_button('Sign up')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
    second_user_signs_in
    click_link 'Endorse'
    expect(page).to have_content('2 endorsements')
  end

end