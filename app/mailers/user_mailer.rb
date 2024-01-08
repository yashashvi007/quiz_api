class UserMailer < ApplicationMailer
  default from: "yashashvimaurya@gmail.com"
  
  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Welcome to the Awesome site")
  end
end
