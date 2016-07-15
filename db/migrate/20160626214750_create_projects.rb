class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name , :nil => false
      t.string :repo , :nil => false , :default => ''
      t.text   :desc , :nil => false , :default => ''

      t.timestamps

    end

    add_index :projects , :name , :unique => true
  end
end
