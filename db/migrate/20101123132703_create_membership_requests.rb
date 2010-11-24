class CreateMembershipRequests < ActiveRecord::Migration
  def self.up
    create_table :membership_requests do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :accepting_admin_id
      t.boolean :accepted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :membership_requests
  end
end
