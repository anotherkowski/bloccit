class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer
    add_index :posts, :topic_id # Creates index on topic_id.
    #Note: Always index your foreign key columns
  end
end
