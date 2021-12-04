class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.boolean :status
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
