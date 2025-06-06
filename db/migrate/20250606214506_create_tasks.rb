class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :due_date
      t.string :priority
      t.boolean :done

      t.timestamps
    end
  end
end
