class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do | t |
      t.string  :topic
      t.boolean :is_open , :nil => false , :default => true

      t.belongs_to :user    , :index => true
      t.belongs_to :project , :index => true

      t.timestamps
    end
  end
end
