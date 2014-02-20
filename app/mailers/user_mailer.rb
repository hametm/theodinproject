class UserMailer < ActionMailer::Base
  default from: "no-reply@theodinproject.com"

  # This is the method that allows one user to contact another
  def send_mail_to_user(message)
    @message = message
    mail(:subject => @message.subject, :to => @message.recipient.email, :from => @message.sender.email)
  end

  # This sends the welcome email after initial signup
  def send_welcome_email_to(user)
    @user = user
    @starting_lesson = Lesson.order("position asc").first
    begin
      attachments.inline['logo.gif'] = File.read(Rails.root.join('app/assets/images/odin_head_silhouette_2_circle_simple_transparent_darker.gif'))
    rescue Exception => e
      puts "Couldn't find the logo image for the welcome email"
      puts e.message
    end
      return mail(
        :subject => "Getting started with The Odin Project",
        :to => user.email,
        :bcc => "erik@theodinproject.com",
        :template_name => "welcome_email"
      )
  end

end
