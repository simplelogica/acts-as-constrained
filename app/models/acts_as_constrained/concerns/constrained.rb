module ActsAsConstrained::Concerns

  module Constrained

    extend ActiveSupport::Concern

    included do

      def self.constrain_by constraint_type, options = {}
        self.include "ActsAsConstrained::Concerns::#{constraint_type.to_s.camelize}Constraint".constantize
      end

    end

  end

end
