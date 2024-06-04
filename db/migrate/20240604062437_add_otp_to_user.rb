class AddOtpToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :otp_secret_key, :string unless column_exists?(:users, :otp_secret_key)

    return if column_exists?(:users, :otp_required_for_login)

    add_column :users, :otp_required_for_login, :boolean
    
  end
end
