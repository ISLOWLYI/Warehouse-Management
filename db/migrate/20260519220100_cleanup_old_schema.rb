class CleanupOldSchema < ActiveRecord::Migration[8.1]
  def up
    # Remove old columns from previous project
    remove_column :users, :username, if_exists: true
    remove_column :users, :admin, if_exists: true
    remove_column :users, :bio, if_exists: true
    remove_column :users, :password_digest, if_exists: true

    # Drop old tables
    drop_table :posts, if_exists: true
  end

  def down
    add_column :users, :username, :string, null: false, default: ""
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :bio, :text
    add_column :users, :password_digest, :string

    create_table :posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
