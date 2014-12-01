class ActionEmail < ActionMailer::Base
  #default :from => "areainf.fce.unrc@gmail.com"
  default :from => "webexa@exa.unrc.edu.ar"

  def prueba(id)
     @user = User.find(id)
     @url  = 'http://codeHero.co'
     mail(to: @user.email, subject: 'Primer mail de prueba')
     mail(:to => @user.email, :subject => "Registered")
  end

  def reset_password_instructions(record, opts={})
      mail(:to => record, :subject => "SME-Instrucciones para reestablecer contraseña de acceso")
  end

end
