class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repo
      t.text :desc

      t.timestamps
    end
  end
end
