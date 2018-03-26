class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true
      t.integer :point

      t.timestamps
      
      t.index [:user_id, :picture_id], unique: true
    end
  end
end
