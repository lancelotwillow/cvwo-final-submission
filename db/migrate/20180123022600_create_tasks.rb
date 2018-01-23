class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :deadline

      t.timestamps null: false
    end
  end
end
