module ActsAsConstrained::Concerns
  module ModelConstraint

    extend ActiveSupport::Concern

    included do

      has_many :model_constraints,
        as: :constrained,
        class_name: "ActsAsConstrained::ModelConstraint"

      scope :constrained_by_model, ->(model_object) do

        relation_alias = "constraints_#{Time.now.to_i}#{(Time.now.subsec*10000).to_i}"

        joins(" INNER JOIN
          acts_as_constrained_model_constraints as #{relation_alias} ON (
              #{relation_alias}.constrained_id = #{self.name.downcase.pluralize}.id AND
              #{relation_alias}.constrained_type = '#{self.name}'
            )"
        ).where(
          relation_alias.to_sym => {
            constraining_type: model_object.class.name,
            constraining_id: [model_object.id]
          }
        )
      end

    end

  end
end
