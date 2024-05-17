class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 64
      t.string :email, null: false, limit: 500
      t.string :password_digest, null: false, limit: 64
      t.timestamps
    end
    
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
