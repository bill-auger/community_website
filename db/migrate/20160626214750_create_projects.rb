class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do | t |
      t.string     :name , :nil => false
      t.string     :repo , :nil => false , :default => ''
      t.text       :desc , :nil => false , :default => ''

      t.belongs_to :user , :index => true

      t.timestamps

    end

    add_index :projects , :name , :unique => true
  end

  def down
    drop_table :users
  end
end
