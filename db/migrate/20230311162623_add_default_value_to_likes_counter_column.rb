class AddDefaultValueToLikesCounterColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :likes_counter, :integer, default: 0
  end
end
