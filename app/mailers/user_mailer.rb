class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Rotten Mangoes')
  end

  def goodbye_email(user)
    @user = user
    @url  = 'http://example.com/signup'
    mail(to: @user.email, subject: 'Goodbye :(')
  end

end
