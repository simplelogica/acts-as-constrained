module ActsAsConstrained::Concerns

  module SingleDateConstraint

    extend ActiveSupport::Concern

    included do

      scope :constrained_by_single_date, ->(time = Time.now) do
        where(
          "? BETWEEN
            single_date_constraint_starts_at AND
            single_date_constraint_ends_at",
          time
        )
      end


    end

  end

end
