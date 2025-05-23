class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[8.0]
  def change
    
    create_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name, null: false
      t.string :nickname, null: false
      t.string :image
      t.string :email
      t.text :bio, default: ""
      t.float :point_rate, null: false, default: 1.0
      t.bigint :points_balance, null: false, default: 0
      t.bigint :all_points, null: false, default: 0
      t.decimal :trust_score, precision: 10, scale: 2, null: false, default: 0.0
      t.integer :role, null: false, default: 0 # 0: user, 1: admin
      t.boolean :is_active, null: false, default: true
      t.datetime :last_login_at

      ## Tokens
      t.text :tokens

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :name,                 unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
