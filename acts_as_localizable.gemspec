# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_localizable}
  s.version = "0.3.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["davydotcom"]
  s.date = %q{2010-11-11}
  s.description = %q{Set ActiveRecord field values or retrieve them based on the I18n current locale or by manually specifying}
  s.email = %q{david.estes@just1word.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README",
     "README.textile",
     "Rakefile",
     "VERSION",
     "acts_as_localizable.gemspec",
     "app/models/localized_field.rb",
     "lib/acts_as_localizable.rb",
     "lib/acts_as_localizable/engine.rb",
     "lib/generators/localized_fields/localized_fields_generator.rb",
     "lib/generators/localized_fields/templates/migration.rb",
     "test/helper.rb",
     "test/test_acts_as_localizable.rb"
  ]
  s.homepage = %q{http://github.com/davydotcom/acts_as_localizable}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Used to store localized fields in your rails database for individual tables}
  s.test_files = [
    "test/helper.rb",
     "test/test_acts_as_localizable.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end

