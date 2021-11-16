class SendNewPasswordMailer < ApplicationMailer

    def send_generated_password(email , password)
        @password = password
        @link = "http://localhost:3000/password/forget_password"
        mail(:to => (email), :subject => "Password Reset Mail")
    end
end
