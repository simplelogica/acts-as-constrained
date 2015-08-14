module ActsAsConstrained::Concerns

  ##
  # This is the general Constrained concern that will add the method to include
  # more constraints and a scope to constrain using a different set of
  # constraints
  #
  # To use it in a model you just have to include the concern and call
  # constrain_by with different options:
  #
  # class MyConstrainedModel < ActiveRecord:.Base
  #
  #   include ActsAsConstrained::Concerns::Constrained
  #
  #   constrain_by :date
  #
  # end
  #
  # And then you can call obtain all your models filtered by date:
  #
  #    MyConstrainedModel.constrained_by date: Date.tomorrow
  #
  # Notice that actual constraining behaviour (with scopes and all that stuff)
  # is not defined in this concern, but in the specific constraint concern (e.g.
  # see ActsAsConstrained::Cocnerns::DateConstraint for the :date constraint)
  module Constrained

    extend ActiveSupport::Concern

    included do

      ##
      # This method just includes the Constraint concern into this class and all
      # the behaviour is delegated to that concern.
      def self.constrain_by constraint_type, options = {}
        constraint_name = constraint_type.to_s.camelize
        self.include "ActsAsConstrained::Concerns::#{constraint_name}Constraint".constantize
      end

      ##
      # General constrained scope. It takes all the constraints you want to
      # apply and creates a chain of scopes.
      #
      # Those scopes must be provided by each concern that is included by the
      # 'constrain_by' method.
      #
      # Constraints are passed as a hash to the scope with the key being the
      # kind of constraint being applied and the value the params passed to the
      # constraining scope.
      #
      # As an example, calling:
      #
      # MyConstrainedModel.constrained_by date: Date.tomorrow, dummy: 99
      #
      # would be equivalent to:
      #
      # MyConstrainedModel.constrained_by_date(Date.tomorrow).
      #   constrained_by_dummy(99)
      scope :constrained_by, ->(constraints) do
        constraints.inject(self) { |result, constraint|
          # We get the constraint kinds and params
          constraint_kind, constraint_values = constraint
          # Now we chain a new scope using the constraint_values as params
          result.send "constrained_by_#{constraint_kind}", constraint_values
        }
      end
    end

  end

end
