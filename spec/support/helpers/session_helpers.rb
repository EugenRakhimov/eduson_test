module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'Подтверждение пароля', :with => confirmation
      click_button 'Зарегистрироваться'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Войти'
    end
  end
end
