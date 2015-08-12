class CreateDateConstraintsOfferTable < ActiveRecord::Migration
  def change
    create_table :acts_as_constrained_date_constraints_offers, id: false do |t|
      t.belongs_to :date_constraint, index: { name: 'index_date_constraints_offers_on_date_constraint_id' }, foreign_key: true
      t.belongs_to :offer, index: true, foreign_key: true
    end
  end
end
