class SessionsController < ApplicationController
  def new
    @user = User.new
    render :layout => false
  end

  def create
    user = login(params[:email], params[:password])
    if user     
      redirect_to user, :notice => "succesvol aangemeld"
    else
      flash.now.alert = "Email of wachtwoord is onbekend, niet geactiveerd of u heeft zich in het verleden aangemeld via Facebook."          
      render :new, :layout => false
    end

  end
  
  def destroy
    logout
    redirect_to root_url #, :notice => "Logged Out!"
  end
end
