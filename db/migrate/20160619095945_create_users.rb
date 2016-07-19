class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do | t |
      t.string  :nick     , :nil => false
      t.string  :uid      , :nil => false
      t.string  :avatar   , :nil => false , :default => ''
      t.string  :bio      , :nil => false , :default => ''
      t.boolean :is_admin , :nil => false , :default => false

      t.timestamps
    end

    add_index :users , :nick , :unique => true
  end

  def down
    drop_table :users
  end
end
