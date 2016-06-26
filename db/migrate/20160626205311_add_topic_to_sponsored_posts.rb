class AddTopicToSponsoredPosts < ActiveRecord::Migration
  def change
    add_column :sponsored_posts, :topic_id_, :integer
    add_index :sponsored_posts, :topic_id_
  end
end
