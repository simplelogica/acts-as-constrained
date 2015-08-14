module ActsAsConstrained::Concerns

  ##
  # This concern uses the ActsAsConstrained::ModelConstraint to create
  # constraints based on one model being related for other.
  #
  # As an example, this can be used to constrain the news shown to a logged user
  # to those belonging the categories the user is subscribed to with a simple
  # line:
  #
  #   News.constrained_by(model: user.subscribed_categories)
  #
  # You just have to create some model_constraint objects to some news objects:
  #
  #   right_new.model_constraints.create(constraining: right_category)
  #
  module ModelConstraint

    extend ActiveSupport::Concern

    included do

      ##
      # Relationship between the constrained model and the model constraint
      # which has information on which constraining object is actually linked
      has_many :model_constraints,
        as: :constrained,
        class_name: "ActsAsConstrained::ModelConstraint"

      ##
      # This scope constrains this model by all the objects received. It
      # receives a list of Active Record objects and creates the needed joins
      # and wheres.
      #
      # Notice that you can mix objects from different classes and the scope
      # will take care of creating the right queries (it must perform a join by
      # each different model included in the scope).
      #
      # You could do: News.constrained_by(model: [section1, section2,
      # category1]) and it will search those news that are constrained by one of
      # those sections and that category.
      #
      # Notice that when more than one object of a model is passed as parameter
      # it performs an OR between all the models. If you want to constrain by
      # the section1 AND the section2 you should chain two constrained_by
      # scopes:
      #
      #   News.constrained_by(model: section1).constrained_by(model: section2)
      scope :constrained_by_model, ->(models) {

        # First we ensure that we have an array of models
        [models].flatten.
          group_by(&:class). # and the we group by the model class
          inject(self) do |result, grouped_models| # Then, for each model

            # We get the model class and the current model objects
            model_class, model_objects = grouped_models

            # We crete an alias for the relationship that includes a timestamp
            # to make sure we don't have repeated joins
            relation_alias = "constraints_#{Time.now.to_i}#{(Time.now.subsec*10000).to_i}"

            # And then we add the join and the restriction on the constraining object
            result.joins(" INNER JOIN
              acts_as_constrained_model_constraints as #{relation_alias} ON (
                  #{relation_alias}.constrained_id = #{self.name.downcase.pluralize}.id AND
                  #{relation_alias}.constrained_type = '#{self.name}'
                )"
            ).where(
              relation_alias.to_sym => {
                constraining_type: model_class.name,
                constraining_id: model_objects.map(&:id)
              }
            )
          end
      }

    end

  end
end
