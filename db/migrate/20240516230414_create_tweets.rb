class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :message, null: false, limit: 140
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    # Check if the index exists before adding it
    unless index_exists?(:tweets, :user_id)
      add_index :tweets, :user_id
    end
  end
end
