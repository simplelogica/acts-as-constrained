class CreateActsAsConstrainedModelConstraints < ActiveRecord::Migration
  def change
    create_table :acts_as_constrained_model_constraints do |t|
      t.belongs_to :constrained, polymorphic: true, index: { name: 'index_model_constraints_on_constrained_type_and_id' }
      t.belongs_to :constraining, polymorphic: true, index: { name: 'index_model_constraints_on_constraining_type_and_id' }

      t.timestamps null: false
    end
  end
end
