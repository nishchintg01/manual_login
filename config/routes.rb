Rails.application.routes.draw do
  root to: 'home#dashboard'
  
  # Login Route
  get 'account/login'
  post 'account/login'

  # Signup Route
  get 'account/signup'
  post 'account/signup'

  # Password Reset Route
  get 'password/forget_password'
  post 'password/forget_password'

  # Password Change Route
  get 'password/reset_password'
  post 'password/reset_password'

  # Edit Profile Route  
  get 'profile/edit_profile'
  post 'profile/edit_profile'
  

  # Logout Route
  get 'account/logout'
end
