class HomeController < ApplicationController


  def index
    #puts "index de HOME CONTROL"
    respond_to do |format|
            format.html { user_signed_in? ? render('logged.html.erb') : render('index.html.erb')  }
    end

  end

end
