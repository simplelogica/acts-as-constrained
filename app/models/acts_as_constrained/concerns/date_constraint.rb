module ActsAsConstrained::Concerns
  module DateConstraint

    extend ActiveSupport::Concern

    included do

      has_many :date_constraints, as: :constrained, class_name: "ActsAsConstrained::DateConstraint"

      scope :constrained_by_date, ->(time = Time.now) do
        joins(:date_constraints).where(
          "? BETWEEN
            acts_as_constrained_date_constraints.starts_at AND
            acts_as_constrained_date_constraints.ends_at",
          time
        )
      end

    end

  end
end
