class CreateUsers < ActiveRecord::Migration[8.1]
  def up
    create_table :users, if_not_exists: true do |t|
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    ensure_users_columns

    add_index :users, :email, unique: true, if_not_exists: true
    add_index :users, :reset_password_token, unique: true, if_not_exists: true
  end

  def down
    remove_index :users, :reset_password_token, if_exists: true
    remove_index :users, :email, if_exists: true
    drop_table :users, if_exists: true
  end

  private

  def ensure_users_columns
    return unless table_exists?(:users)

    unless column_exists?(:users, :email)
      add_column :users, :email, :string, null: false, default: ""
    end
    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, null: false, default: ""
    end
    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
    end
    unless column_exists?(:users, :reset_password_sent_at)
      add_column :users, :reset_password_sent_at, :datetime
    end
    unless column_exists?(:users, :remember_created_at)
      add_column :users, :remember_created_at, :datetime
    end
    unless column_exists?(:users, :created_at)
      add_column :users, :created_at, :datetime, null: false, default: Time.current
    end
    unless column_exists?(:users, :updated_at)
      add_column :users, :updated_at, :datetime, null: false, default: Time.current
    end
  end
end
