class UserMailer < ApplicationMailer

  def account_activation user
    @user = user

<<<<<<< HEAD
    mail to: user.email, subject: t(".subject")
=======
    mail to: user.email, subject: "Account activation"
>>>>>>> account-active
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
