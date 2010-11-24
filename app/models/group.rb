class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :membership_requests, :dependent => :destroy
  has_many :users, :through => :memberships 
  def admins
    memberships.where(:admin => true).map {|t| t.user}
  end
      
  def admin?(user)
    admins.include?(user)
  end
      
  def members
    memberships.map {|t| t.user}
  end
  
  def member?(user)
    members.include?(user)
  end
end
