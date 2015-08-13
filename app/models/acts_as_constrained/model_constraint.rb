module ActsAsConstrained
  class ModelConstraint < ActiveRecord::Base
    belongs_to :constrained, polymorphic: true
    belongs_to :constraining, polymorphic: true
  end
end
