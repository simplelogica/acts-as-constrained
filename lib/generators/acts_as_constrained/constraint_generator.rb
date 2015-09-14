class ActsAsConstrained::ConstraintGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_concern
    template "concerns/constraint_concern.erb",
      File.join(destination_root, "app/models/acts_as_constrained/concerns/#{name.underscore}_constraint.rb")
  end
end
