class MembershipRequestsController < ApplicationController
  def create
     @membership_request = current_user.membership_requests.build(:group_id => params[:group_id])
     @membership_requests = MembershipRequest.create(:user => current_user, :group_id => params[:group_id])
     if @membership_request.save
       flash[:notice] = "oczekiwanie na dodanie do grupy"
       redirect_to groups_path
     else
       flash[:notice] = "spierdzielilysmy=p"
     end
   end
   
   def accept
    membership_request = current_user.membership_requests.find(params[:id])
    user = membership_request.user
    group = membership_request.group
    #membership = Membership.new(:user => user, :group => group)
    membership = group.memberships.create(:user => user)
    if membership.valid?
      membership_request.destroy
      redirect_to group_path(group)
    else
      flash[:notice] = "akceptacja nie powiodla się"
      redirect_to group_path(group)
    end
    #dodanie użytkownika który prosił o dodanie do grupy(do grupy do której chciał) przez administratora tej grupy
   end

   def destroy
     @membership_request = current_user.membership_requests.find(params[:id])
     @membership_request.destroy
     redirect_to groups_path
   end
end
