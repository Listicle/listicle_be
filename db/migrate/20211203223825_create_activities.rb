class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.references :project, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
