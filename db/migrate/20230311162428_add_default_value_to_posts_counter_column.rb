class AddDefaultValueToPostsCounterColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :posts_counter, :integer, default: 0
  end
end
