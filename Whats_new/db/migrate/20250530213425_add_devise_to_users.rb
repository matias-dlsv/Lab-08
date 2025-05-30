class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      unless column_exists?(:users, :email)
        t.string :email,              null: false, default: ""
      end
      unless column_exists?(:users, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      ## Recoverable
      unless column_exists?(:users, :reset_password_token)
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
      end

      ## Rememberable
      unless column_exists?(:users, :remember_created_at)
        t.datetime :remember_created_at
      end

      # … idem para los demás bloques si los descomentas
    end

    # Índices
    add_index :users, :email,                unique: true   unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true   unless index_exists?(:users, :reset_password_token)
    # …
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
