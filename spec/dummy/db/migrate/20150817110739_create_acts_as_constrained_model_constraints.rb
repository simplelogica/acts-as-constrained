class CreateActsAsConstrainedModelConstraints < ActiveRecord::Migration
  def change
    create_table :acts_as_constrained_model_constraints do |t|
      t.references :constraining, polymorphic: true, index: { name: 'index_model_constraints_on_constraining_type_and_id' }
      t.references :constrained, polymorphic: true, index: { name: 'index_model_constraints_on_constrained_type_and_id' }
    end
  end
end
