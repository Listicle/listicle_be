class ChangeStatusEnumToString < ActiveRecord::Migration[6.1]
  def change
    change_column :activities, :status, :string
  end
end
