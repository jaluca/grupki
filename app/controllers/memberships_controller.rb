class MembershipsController < ApplicationController
  
  def create
    @membership = current_user.memberships.build(:group_id => params[:group_id])
    if @membership.save
      flash[:notice] = "dodano do grupy"
      redirect_to group_path(@membership.group) 
    else
      flash[:notice] = "spierdzielilyscie=p"
    end
  end
    
  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    redirect_to groups_path
  end
 
end
