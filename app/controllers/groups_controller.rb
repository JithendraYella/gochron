class GroupsController < ApplicationController

   def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_login_url # halts request cycle
    end
  end  

   def index
     if params[:request_type ] == 'All'
	@group = Group.all 
    elsif params[:request_type] == 'MyGroups'
        @group = Group.where(:user_id => current_user.id)
    elsif params[:request_type] == 'Subscribed'
        @group = Group.where(:user_id => current_user.id)
    else
        @group = Group.where(:user_id => current_user.id)	
    end
   end

  def new
     @group = Group.new
  end

  def edit 
     @group = Group.find(params[:id])
   end

   def show
     @group = Group.find(params[:id])	
   end

  def create
     @group = Group.new(params[:group].permit(:name,:description))
     @group.user_id = current_user.id
     if @group.save
     redirect_to @group
     else
       render 'new' 
     end
   end

    def destroy
    @group = Group.find(params[:id])
    @group.destroy
 
    redirect_to groups_path
  end
end
