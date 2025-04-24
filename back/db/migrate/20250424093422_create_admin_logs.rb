class CreateAdminLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_logs do |t|
      t.timestamps
    end
  end
end
