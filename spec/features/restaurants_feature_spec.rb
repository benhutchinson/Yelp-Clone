require 'rails_helper'

feature 'restaurants' do

  def sign_in
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content "I'M HUNGRY"
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do 
    before do 
      Restaurant.create(name: 'Pilpel')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Pilpel')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    scenario 'prompts a signed-in user to fill out a form, then displays the new restaurant' do
      sign_in
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'GO FISHING HONEY MONSTER'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'is not possible for signed-out users' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in'
    end

  end

  context 'viewing restaurants' do

    before do
      @kfc = Restaurant.create(name:'KFC')
    end

    it 'lets a user view a restaurant' do
     visit '/restaurants'
     click_link 'KFC'
     expect(page).to have_content 'KFC'
     expect(current_path).to eq "/restaurants/#{@kfc.id}"
    end

  end

  context 'editing restaurants' do

    before {Restaurant.create(name: 'Little Chef')}

    it 'lets a signed-in user edit a restaurant' do 
      sign_in
      visit '/restaurants'
      click_link 'Edit Little Chef'
      fill_in 'Name', with: 'Little Chef'
      click_button 'UPDATE ME HONEY MONSTER'
      expect(page).to have_content 'Little Chef'
      expect(current_path).to eq '/restaurants'
    end

    it 'wont let a signed-out user edit a restaurant' do 
      visit '/restaurants'
      click_link 'Edit Little Chef'
      expect(page).to have_content 'You need to sign in'
    end

  end

  context 'deleting restaurants' do

  before {Restaurant.create name: 'KFC'}

    scenario 'removes a restaurant when a signed-in user clicks a delete link' do
      sign_in
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario ' does not remove a restaurant when a signed-out user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content 'You need to sign in'
    end

  end

  context 'an invalid restaurant' do 
    scenario 'does not let you submit a name that is too short' do
      sign_in 
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'GO FISHING HONEY MONSTER'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end

    scenario "is not valid unless it has a unique name" do
      Restaurant.create(name: "Moe's Tavern")
      restaurant = Restaurant.new(name: "Moe's Tavern")
      expect(restaurant).to have(1).error_on(:name)
    end
    
  end

end