class AddUuidToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :uuid, :uuid
    add_index :messages, :uuid, unique: true
  end
end
