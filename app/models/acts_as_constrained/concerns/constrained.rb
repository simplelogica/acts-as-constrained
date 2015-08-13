module ActsAsConstrained::Concerns

  module Constrained

    extend ActiveSupport::Concern

    included do

      def self.constrain_by constraint_type, options = {}
        self.include "ActsAsConstrained::Concerns::#{constraint_type.to_s.camelize}Constraint".constantize
      end

      scope :constrained_by, ->(constraints) do
        constraints.inject(self) { |result, constraint|
          constraint_kind, constraint_values = constraint
          result.send "constrained_by_#{constraint_kind}", constraint_values
        }
      end
    end

  end

end
