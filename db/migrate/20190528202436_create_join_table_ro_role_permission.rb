class CreateJoinTableRoRolePermission < ActiveRecord::Migration[5.2]
  def change
    create_join_table :roles, :permissions do |t|
      t.index [:role_id, :permission_id]
    end
  end
end
