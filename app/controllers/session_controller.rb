class SessionController < ApplicationController
  def new
  end

  def create
    @author = Author.find_by name:  params[:username]
    if !@author
      flash.now.alert = "El autor #{params[:username]} no existe"
      render :new
    elsif @author.password == params[:password]
      session[:author] = @author.name
      redirect_to root_url, :notice => "Sesion Iniciada"
    else
      flash.now.alert = "Clave Incorrecta"
      render :new
    end
  end

  def destroy
    session[:author] = nil
    redirect_to :root, :notice => "Sesion Cerrada"
  end
end
