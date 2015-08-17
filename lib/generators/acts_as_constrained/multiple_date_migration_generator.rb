class ActsAsConstrained::MultipleDateMigrationGenerator < Rails::Generators::Base
  def create_migrations
    generate "migration", "CreateActsAsConstrainedDateConstraints starts_at:date ends_at:date constrained:references{polymorphic}"
  end
end
