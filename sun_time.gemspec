# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sun_time}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carl-Johan Kihlbom"]
  s.date = %q{2009-07-23}
  s.description = %q{Calculate the time of sunrise and sunset for location on a specific date.}
  s.email = ["cj@elabs.se"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/sun_time.rb", "lib/sun_time/date_ext.rb", "lib/sun_time/degree_trig.rb", "script/console", "script/destroy", "script/generate", "test/test_date_ext.rb", "test/test_degree_trig.rb", "test/test_sun_time.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/elabs/sun_time}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{elabs}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Calculate the time of sunrise and sunset for location on a specific date.}
  s.test_files = ["test/test_date_ext.rb", "test/test_degree_trig.rb", "test/test_sun_time.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.5.3"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
      s.add_dependency(%q<newgem>, [">= 1.5.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
    s.add_dependency(%q<newgem>, [">= 1.5.3"])
  end
end
