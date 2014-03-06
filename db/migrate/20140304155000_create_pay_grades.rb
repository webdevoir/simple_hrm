class CreatePayGrades < ActiveRecord::Migration
  def change
    create_table :pay_grades do |t|
      t.string :name
      t.integer :currency, default: 1
      t.integer :min_salary
      t.integer :max_salary

      t.timestamps
    end
  end
end
