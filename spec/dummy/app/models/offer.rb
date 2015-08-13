class Offer < ActiveRecord::Base
  has_many :date_constraints, as: :constrained, class_name: "ActsAsConstrained::DateConstraint"
  has_many :model_constraints, as: :constrained, class_name: "ActsAsConstrained::ModelConstraint"

  scope :constrained_by_date, ->(time = Time.now) { joins(:date_constraints).where("? BETWEEN acts_as_constrained_date_constraints.starts_at AND acts_as_constrained_date_constraints.ends_at", time) }
  scope :constrained_by_market, ->(market) { joins(' INNER JOIN "acts_as_constrained_model_constraints" as market_constraints ON "market_constraints"."constrained_id" = "offers"."id" AND "market_constraints"."constrained_type" = \'Offer\'').where(market_constraints: { constraining_type: market.class.name, constraining_id: [market.id]} ) }
  scope :constrained_by_country, ->(country) { joins(' INNER JOIN "acts_as_constrained_model_constraints" as country_constraints ON "country_constraints"."constrained_id" = "offers"."id" AND "country_constraints"."constrained_type" = \'Offer\'').where(country_constraints: { constraining_type: country.class.name, constraining_id: [country.id]} ) }

  scope :constrained_by_model, ->(model_object) do

  end
end
