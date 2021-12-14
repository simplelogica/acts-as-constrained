ruby_version = Gem::Version.new(RUBY_VERSION)

ruby_2_5_0 = Gem::Version.new('2.5.0')

if ruby_version < ruby_2_5_0
  appraise "rails-4-0-mysql" do
    gem "mysql2", "~> 0.3.13"
    gem "rails", "4.0.13"
  end

  appraise "rails-4-1-mysql" do
    gem "mysql2", "~> 0.3.13"
    gem "rails", "4.1.14"
  end

  appraise "rails-4-2-mysql" do
    gem "mysql2"
    gem "rails", "4.2.5"
  end

  appraise "rails-5-0-mysql" do
    gem "mysql2"
    gem "rails", "5.0.0"
  end

  appraise "rails-4-0-pgsql" do
    gem "pg"
    gem "rails", "4.0.13"
  end

  appraise "rails-4-1-pgsql" do
    gem "pg"
    gem "rails", "4.1.14"
  end

  appraise "rails-4-2-pgsql" do
    gem "pg"
    gem "rails", "4.2.5"
  end

  appraise "rails-5-0-pgsql" do
    gem "pg"
    gem "rails", "5.0.0"
  end

  appraise "rails-5-2-3" do
    gem "rails", "5.2.3"
  end
end

appraise "rails-6-1-4-1" do
  gem "pg"
  gem "rails", "6.1.4.1"
end
