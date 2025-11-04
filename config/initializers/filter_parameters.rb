Rails.application.config.filter_parameters += [
  :password,
  :password_confirmation,
  :encrypted_password
]
