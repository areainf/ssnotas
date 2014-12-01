=begin
ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => "areainf.fce.unrc@gmail.com",
    :password             => "matecito2012",
    :authentication       => "plain",
    :enable_starttls_auto => true
}

=end

ActionMailer::Base.smtp_settings = {
    :address              => "imap.exa.unrc.edu.ar",
    :domain               => "exa.unrc.edu.ar",
    :user_name            => "webexa",
    :password             => "sitionvo",
    :authentication       => "plain",
    :enable_starttls_auto => true
}
