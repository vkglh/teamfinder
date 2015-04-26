class UserMailer < ActionMailer::Base

  default from: 'support@lolteam.io'
  default from_name: 'LOL Team Finder'

  DEFAULT_REPLY_TO = 'LOL Team Finder <support@lolteam.io>'
end
