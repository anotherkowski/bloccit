class AddCommentToTopics < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.remove :post_id
      t.references :commentable, :polymorphic => true, index: true
    end
  end
end
