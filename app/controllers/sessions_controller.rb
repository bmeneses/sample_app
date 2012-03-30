class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user # instead of redirect_to user, use helper to figure out where
                            # the user attempted to access before logging in
    else
      #error out and re-render the signin form
      flash.now[:error] = 'Invalid email/password combination' # not right?
      render 'new'
    end
    
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
