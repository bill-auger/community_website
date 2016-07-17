class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :nick , :nil => false
      t.string :uid  , :nil => false
      t.string :bio  , :nil => false , :default => ''

      t.timestamps
    end

    add_index :users , :nick , :unique => true
  end

  def down
    drop_table :users
  end
end
