class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    # build is used to create both the micropost and set its FK
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = [] # failure routes through the microposts controller, and the next
                       # page is expecting a @feed_items ivar
      render 'static_pages/home'
    end
    
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private
    
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to_root_path if @micropost.nil?
    end
    
  
end