class ChangeWelcomeCallForeignKeys < ActiveRecord::Migration[5.2]
  def change
    remove_column :welcome_calls, :user_id
    add_reference :welcome_calls, :booking, index: true, foreign_key: true
  end
end
