class Offer < ActiveRecord::Base
  has_many :date_constraints, as: :constrained, class_name: "ActsAsConstrained::DateConstraint"
  has_many :model_constraints, as: :constrained, class_name: "ActsAsConstrained::ModelConstraint"

  scope :constrained_by_date, ->(time = Time.now) { joins(:date_constraints).where("? BETWEEN acts_as_constrained_date_constraints.starts_at AND acts_as_constrained_date_constraints.ends_at", time) }
  scope :constrained_by_market, ->(market) { joins(:model_constraints).where(acts_as_constrained_model_constraints: { constraining_type: market.class.name, constraining_id: [market.id]} ) }
end
