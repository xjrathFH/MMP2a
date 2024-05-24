class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :access_token
      t.datetime :token_expires_at
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :status
      t.string :department
      t.string :studies
      t.boolean :is_admin
      t.float :balance
      t.string :username

      t.timestamps
    end
  end
end
