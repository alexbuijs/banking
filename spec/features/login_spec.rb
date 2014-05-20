require 'spec_helper'

describe 'Login' do
  let!(:user) { create :user, username: 'test_user', password: 'test_password' }

  before do
    visit root_path
    click_link 'Sign in'
  end

  context 'With correct credentials' do
    it 'shows an success message' do
      within '#new_user' do
        fill_in 'Username', with: 'test_user'
        fill_in 'Password', with: 'test_password'
        click_button 'Sign in'
      end

      expect(page).to have_content 'Signed in successfully.'
    end
  end

  context 'With incorrect credentials' do
    it 'shows an error message' do
      within '#new_user' do
        fill_in 'Username', with: 'test_user'
        fill_in 'Password', with: 'wrong_password'
        click_button 'Sign in'
      end

      expect(page).to have_content 'Invalid username or password.'
    end
  end

  context 'With non existing username' do
    it 'shows an error message' do
      within '#new_user' do
        fill_in 'Username', with: 'wrong_user'
        fill_in 'Password', with: 'test_password'
        click_button 'Sign in'
      end

      expect(page).to have_content 'Invalid username or password.'
    end
  end
end

describe 'Logout' do
  let!(:user) { create :user }

  before do
    login_as(user)
    visit root_path
  end

  context 'Already logged in' do
    it 'doesn\'t show the login link' do
      expect(page).not_to have_link 'Sign in'
    end

    it 'shows logout link' do
      expect(page).to have_link 'Sign out'
    end
  end
end