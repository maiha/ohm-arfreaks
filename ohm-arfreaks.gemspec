# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ohm-arfreaks}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["maiha"]
  s.date = %q{2010-03-17}
  s.description = %q{Ohm::Model extensions for AR freaks}
  s.email = %q{maiha@wota.jp}
  s.extra_rdoc_files = ["README.markdown", "LICENSE"]
  s.files = ["LICENSE", "README.markdown", "Rakefile", "lib/ohm-arfreaks.rb", "spec/db", "spec/db/redis.pid", "spec/attributes_spec.rb", "spec/redis.conf", "spec/provide_helper.rb", "spec/columns_spec.rb", "spec/model.rb", "spec/methods_spec.rb", "spec/its_helper.rb", "spec/spec_helper.rb", "spec/validations_spec.rb"]
  s.homepage = %q{http://github.com/maiha/ohm-arfreaks}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{asakusarb}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ohm::Model extensions for AR freaks}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
