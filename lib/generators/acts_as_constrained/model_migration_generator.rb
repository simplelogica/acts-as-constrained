class ActsAsConstrained::ModelMigrationGenerator < Rails::Generators::Base
  def create_migrations
    generate "migration", "CreateActsAsConstrainedModelConstraints constraining:references{polymorphic} constrained:references{polymorphic}"
  end
end
