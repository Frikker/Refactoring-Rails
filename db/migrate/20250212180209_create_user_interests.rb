class CreateUserInterests < ActiveRecord::Migration[8.0]
  def change
    create_table :user_interests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :interest, index: true, foreign_key: true
      t.timestamps
    end
  end
end
