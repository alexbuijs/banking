require 'spec_helper'

feature 'Login' do
  background do
    visit root_path
  end

  scenario 'With correct credentials' do
    within '#login_form' do
      fill_in 'username', with: 'username'
      fill_in 'password', with: 'password'
      find('#login').click
    end

    expect(page).to have_content 'Logged in successfully'
  end
end