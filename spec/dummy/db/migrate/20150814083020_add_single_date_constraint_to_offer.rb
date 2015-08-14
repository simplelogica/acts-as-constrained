class AddSingleDateConstraintToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :single_date_constraint_starts_at, :date
    add_column :offers, :single_date_constraint_ends_at, :date
  end
end
