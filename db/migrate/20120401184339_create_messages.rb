class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user
      t.integer :to_user_id
      t.integer :room_id
      t.text :message
      t.boolean :readed, :default => false

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :to_user_id
    add_index :messages, :room_id
  end
end
