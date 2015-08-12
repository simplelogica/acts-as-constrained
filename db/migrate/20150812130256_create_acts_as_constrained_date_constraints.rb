class CreateActsAsConstrainedDateConstraints < ActiveRecord::Migration
  def change
    create_table :acts_as_constrained_date_constraints do |t|
      t.date :starts_at
      t.date :ends_at

      t.timestamps null: false
    end
  end
end
