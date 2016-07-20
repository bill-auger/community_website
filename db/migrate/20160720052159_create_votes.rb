class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do | t |
      t.belongs_to :user        , :index => true
      t.belongs_to :poll        , :index => true
      t.belongs_to :poll_option , :index => true

      t.timestamps
    end

    add_index :votes , [ :user_id , :poll_id ] , :unique => true
  end

  def down
    drop_table :votes
  end
end
