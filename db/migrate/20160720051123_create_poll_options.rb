class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do | t |
      t.string  :option   , :nil => false
      t.boolean :is_other , :nil => false , :default => false

      t.belongs_to :poll , :index => true
#       t.belongs_to :vote , :index => true

      t.timestamps
    end
  end
end
