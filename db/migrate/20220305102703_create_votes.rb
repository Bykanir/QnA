class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :score, null: false, default: 0
      t.references :user
      t.belongs_to :votable, polymorphic: true

      t.timestamps
    end
  end
end
