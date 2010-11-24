class GroupsController < ApplicationController
  before_filter :load_group, :except => [:new, :index, :create]
  before_filter :authenticate_user!, :except => [:index]
  attr_reader :per_page
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group])
    if @group.save
      @membership = @group.memberships.create(:user_id => current_user.id, :admin => true)
      if @membership.save
        redirect_to group_path(@group)
      else
        @group.delete
        render :action => 'new'
        end
    else
      render :action => :new
    end
  end

  def index
    @search = Group.search(params[:search])
    @groups = @search.paginate(:page => params[:page], :per_page => 2)  
  end

  def show
    @users = @group.users
  end
  
  def edit
  end
  
  def update
     @group.update_attributes(params[:group])
     redirect_to @group
   end
  
  def destroy
    @group.destroy
    redirect_to groups_path
  end

private 

	def load_group
	  @group = Group.find(params[:id])
  end
end
