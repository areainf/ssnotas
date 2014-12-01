#CREADA PARA QUE CUANDO FALLE EL LOGIN
#REGRESE A LA HOME Y NO A users/sign_in
#TAMBIEN SE MODIFICO EL ARCHIVO Devise initializer,
 class CustomFailure < Devise::FailureApp
    def redirect_url
        if request.xhr?
            #tambien usa el archivo /views/devise/sessions/new.js.haml
            send(:"new_#{scope}_session_path", :format => :js)
        else
            root_path
        end
    end
    def respond
        if http_auth?
            http_auth
        else
            redirect
        end
    end
 end