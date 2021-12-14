ruby_version = Gem::Version.new(RUBY_VERSION)

ruby_2_5_0 = Gem::Version.new('2.5.0')

if ruby_version < ruby_2_5_0
  appraise "rails-4-0" do
    gem "rails", "4.0.13"
  end

  appraise "rails-4-1" do
    gem "rails", "4.1.12"
  end

  appraise "rails-4-2" do
    gem "rails", "4.2.3"
  end

  appraise "rails-5-2-3" do
    gem "rails", "5.2.3"
  end
end

appraise "rails-6-0" do
  gem "rails", "6.1.4.1"
end
