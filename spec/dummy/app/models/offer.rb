class Offer < ActiveRecord::Base
  has_and_belongs_to_many :date_constraints, class_name: "ActsAsConstrained::DateConstraint"

  scope :constrained_by_date, ->(time = Time.now) { joins(:date_constraints).where("? BETWEEN acts_as_constrained_date_constraints.starts_at AND acts_as_constrained_date_constraints.ends_at", time) }
end
