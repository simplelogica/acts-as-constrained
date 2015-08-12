class AddConstrainedToDateConstraint < ActiveRecord::Migration
  def change
    add_reference :acts_as_constrained_date_constraints, :constrained, index: { name: 'index_date_constraints_on_constrained_type_and_constrained_id' }, polymorphic: true
  end
end
