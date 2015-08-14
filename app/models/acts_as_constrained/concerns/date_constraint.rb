module ActsAsConstrained::Concerns

  ##
  # This concern uses the ActsAsConstrained::DateConstraint to create multiple
  # date constraints over a model.
  #
  # This is used when you want to have a model enabled only in certain periods
  # of time.
  #
  # Notice that this concern is used when the constrained object may be active
  # in multiple periods of time. If you only want to allow one period of time
  # you should consider using the SingleDateConstraint as it stores the info in
  # the same table and prevents joins between tables.
  module DateConstraint

    extend ActiveSupport::Concern

    included do

      ##
      # Polymorphic relationship between the constrained model and the date
      # constraints
      has_many :date_constraints, as: :constrained, class_name: "ActsAsConstrained::DateConstraint"

      ##
      # Scope that performs the joins with the date_constraints table and
      # filters the dates
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
