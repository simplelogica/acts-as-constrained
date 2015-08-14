class ActsAsConstrained::SingleDateMigrationGenerator < Rails::Generators::NamedBase
  def create_migrations
    generate "migration", "AddSingleDateConstraintTo#{class_name} single_date_constraint_starts_at:date single_date_constraint_ends_at:date"
  end
end
