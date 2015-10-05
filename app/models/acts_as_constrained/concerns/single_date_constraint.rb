module ActsAsConstrained::Concerns

  ##
  # This concern uses some model attributes to create a single date constraint
  # over the model.
  #
  # In order to create the attributes you should run the
  # acts_as_constrained:single_date_migration generator in order to create a
  # migration.
  module SingleDateConstraint

    extend ActiveSupport::Concern

    included do

      scope :constrained_by_single_date, ->(time = Time.now) do
        where(
          "(
            ? >= single_date_constraint_starts_at AND
            single_date_constraint_ends_at IS NULL
          ) OR
          (
            ? <= single_date_constraint_ends_at AND
            single_date_constraint_starts_at IS NULL
          ) OR
          (
            ? BETWEEN
              single_date_constraint_starts_at AND
              single_date_constraint_ends_at
          )",
          time, time, time
        )
      end


    end

  end

end
