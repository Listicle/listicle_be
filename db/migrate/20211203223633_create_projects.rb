class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
